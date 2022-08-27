//
//  ViewController.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 22.08.2022.
//

import UIKit
import Security
struct Credentials {
        let username: String
        var password: String
        let serviceName = "UserCredentials"
    }
var credential = Credentials(username: "NewUser118", password: "passwordSecond")

class ViewController: UIViewController {
    
    enum State {
        case createPassword
        case checkCreatePassword
        case inputPassword
        case checkInputPassword
    }
    private(set) var state: State = .createPassword
    
    private var passwordFirst: String = ""
    
    let password: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemYellow
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Создать пароль", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let buttonTwo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("У меня уже есть пароль", for: .normal)
        button.addTarget(self, action: #selector(buttonTappedTwo), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        setup()

    }

    func setup(){
        self.view.addSubview(password)
        self.view.addSubview(button)
        self.view.addSubview(buttonTwo)
        
        NSLayoutConstraint.activate([
            
            self.password.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.password.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.password.heightAnchor.constraint(equalToConstant: 50),
            self.password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 50),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            self.button.widthAnchor.constraint(equalTo: self.password.widthAnchor),
            
            self.buttonTwo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonTwo.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 15),
            self.buttonTwo.heightAnchor.constraint(equalToConstant: 30),
            self.buttonTwo.widthAnchor.constraint(equalTo: self.password.widthAnchor)
        ])
    }
    func stateChange(_ state: State){
        
        switch state {
        case .createPassword:
            guard let password = self.password.text, !password.isEmpty, !password.contains(" "), password.count >= 4  else {
                print("Missing field data")
                let alert = customAlert(message: "Не корректно заполнены поля")
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.passwordFirst = password
            self.buttonTwo.isHidden = true
            self.button.setTitle("Повторите пароль", for: .normal)
            self.password.text = ""
            self.state = .checkCreatePassword
            
        case .checkCreatePassword:
            guard let passwordSecond = self.password.text, passwordSecond == self.passwordFirst else {
                print("Missing field data")
                let alert = customAlert(message: "Пароли не совпали")
                self.present(alert, animated: true, completion: nil)
                self.button.setTitle("Создать пароль", for: .normal)
                self.password.text = ""
                self.buttonTwo.isHidden = false
                self.state = .createPassword
                return
            }
            print("пароли совпали")
            credential.password = passwordSecond
            setPassword(with: credential)
            navigationController?.pushViewController(TabBarController(), animated: true)
            navigationController?.setNavigationBarHidden(true, animated: true)
            
        case .inputPassword:
            guard let password = self.password.text, !password.isEmpty, !password.contains(" "), password.count >= 4  else {
                print("Missing field data")
                let alert = customAlert(message: "Не корректно заполнены поля")
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.passwordFirst = password
            self.buttonTwo.isHidden = true
            self.button.setTitle("Повторите пароль", for: .normal)
            self.password.text = ""
            self.state = .checkInputPassword
            
        case .checkInputPassword:
            guard let passwordSecond = self.password.text, passwordSecond == self.passwordFirst else {
                print("Missing field data")
                let alert = customAlert(message: "Пароли не совпали")
                self.present(alert, animated: true, completion: nil)
                self.button.setTitle("Создать пароль", for: .normal)
                self.password.text = ""
                self.buttonTwo.isHidden = false
                self.state = .createPassword
                return
            }
            print("пароли совпали")
            guard let password = retrievePassword(with: credential), password == passwordSecond else {
                let alert = customAlert(message: "Пароль не найден в Keychain")
                self.present(alert, animated: true, completion: nil)
                self.button.setTitle("Создать пароль", for: .normal)
                self.password.text = ""
                self.buttonTwo.isHidden = false
                self.state = .createPassword
                return}
            navigationController?.pushViewController(TabBarController(), animated: true)
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    @objc private func buttonTapped(){
        stateChange(self.state)
    }
    
    @objc private func buttonTappedTwo(){
        self.state = .inputPassword
        self.button.setTitle("Введите пароль", for: .normal)
        self.buttonTwo.isHidden = true
    }
}

func customAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK", style: .cancel) { actionOk in
        print("Tap Ok")
    }
    alert.addAction(actionOk)
    return alert
}

func retrievePassword(with credentials: Credentials) -> String? {
    // Создаем поисковые атрибуты
    print(credentials.password)
    let query = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: credentials.serviceName,
        kSecAttrAccount: credentials.username,
        kSecReturnData: true
    ] as CFDictionary

    // Объявляем ссылку на объект, которая в будущем будет указывать на полученную запись Keychain
    var extractedData: AnyObject?
    // Запрашиваем запись в keychain
    let status = SecItemCopyMatching(query, &extractedData)

    guard status == errSecItemNotFound || status == errSecSuccess else {
        print("Невозможно получить пароль, ошибка номер: \(status)")
        return nil
    }

    guard status != errSecItemNotFound else {
        print("Пароль не найден в Keychain")
        return nil
    }

    guard let passData = extractedData as? Data,
          let password = String(data: passData, encoding: .utf8) else {
        print("невозможно преобразовать data в пароль")
        return nil
    }

    return password
}
func setPassword(with credentials: Credentials) {
    // Переводим пароль в объект класс Data
    guard let passData = credentials.password.data(using: .utf8) else {
        print("Невозможно получить Data из пароля")
        return
    }
    // Создаем атрибуты для хранения файла
    let attributes = [
        kSecClass: kSecClassGenericPassword,
        kSecValueData: passData,
        kSecAttrAccount: credentials.username,
        kSecAttrService: credentials.serviceName,
    ] as CFDictionary

    // Добавляем новую запись в Keychain
    let status = SecItemAdd(attributes, nil)

    guard status == errSecDuplicateItem || status == errSecSuccess else {
        print("Невозможно добавить пароль, ошибка номер: \(status)")
        return
    }

    print("Новый пароль добавлен успешно")
}
