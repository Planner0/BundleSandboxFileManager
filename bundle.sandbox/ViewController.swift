//
//  ViewController.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 14.08.2022.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "images")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 55
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        self.view.addSubview(imageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(goToImagePicker))
        setup()
        
        let fileManager = FileManager.default
        do {
            let documentUrl = try fileManager.url(for: .documentDirectory,
                                                     in: [.userDomainMask],
                                                     appropriateFor: nil,
                                                     create: false)
            //print(documentUrl)
            
            let someImage = UIImage(named: "images") ?? UIImage()
            let data = someImage.jpegData(compressionQuality: 1.0)
            
            let imagePath = documentUrl.appendingPathComponent("red5.jpg")
            //            do {
//                let fileExist = try fileManager.fileExists(atPath: imagePath.path)
//                print(fileExist)
//            } catch let error {
//                print(error)
//            }
            //try fileManager.removeItem(atPath: documentUrl.path)
            try fileManager.createFile(atPath: imagePath.path, contents: data)
//            do {
//                let attributes = try fileManager.attributesOfItem(atPath: imagePath.path)
//                print(attributes)
//            } catch let error {
//                print(error)
//            }
            do {
                let contents = try fileManager.contentsOfDirectory(at: documentUrl,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: [.skipsHiddenFiles])
                for file in contents {
                    let filePath = file.path
                    print("File path: \(filePath)")
                    if fileManager.fileExists(atPath: imagePath.path) {
                      try fileManager.removeItem(atPath: filePath)
                    }
                }
            } catch let error {
                print(error)
            }
        } catch let error {
            print(error)
        }

    }
    
    func setup(){
        NSLayoutConstraint.activate([
            
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            self.imageView.widthAnchor.constraint(equalToConstant: 200),
            self.imageView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    @objc func goToImagePicker(){
        print("Pick")
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
        
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.imageView.image = tempImage
            self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false, completion: nil)
    }
}
