//
//  TableViewController.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 14.08.2022.
//

import UIKit

class TableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var fileNameArray: [String] = []
    var fileAttributeArray: [String] = []
    let fileManager = FileManager.default
    var defaults = UserDefaults.standard
    
    override func loadView() {
        super.loadView()
        do { let documentUrl = try fileManager.url(for: .documentDirectory,
                                                      in: [.userDomainMask],
                                                      appropriateFor: nil,
                                                      create: false)
            do {
                let contents = try fileManager.contentsOfDirectory(at: documentUrl,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: [.skipsHiddenFiles])
                for file in contents {
                    let filePath = file.lastPathComponent
                    let attributes = try fileManager.attributesOfItem(atPath: file.path) as NSDictionary
                    print("File path: \(filePath)")
                    fileNameArray.append(filePath)
                    let date = attributes.fileCreationDate()!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    let string = dateFormatter.string(from: date)
                    fileAttributeArray.append(string)
                }
            } catch let error {
                print(error)
            }
        } catch let error {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(goToImagePicker))
 
    }
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()

 
    }
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        if self.defaults.bool(forKey: "isSorted") {
            self.fileNameArray = self.fileNameArray.sorted(by: <)
            self.tableView.reloadData()
        } else {
            self.fileNameArray = self.fileNameArray.sorted(by: >)
            self.tableView.reloadData()
        }
        print(self.defaults.bool(forKey: "isSorted"))
        
    }

    @objc func goToImagePicker(){
        print("Pick")
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let documentUrl = try! fileManager.url(for: .documentDirectory,
                                                  in: [.userDomainMask],
                                                  appropriateFor: nil,
                                                  create: false)
        let name = self.fileNameArray[indexPath.row]
        let imagePath = documentUrl.appendingPathComponent(name)
        
        let contextItem = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, success) in
            print("delete")
            
            try! self.fileManager.removeItem(atPath: imagePath.path)
            
            print(self.fileNameArray[indexPath.row])
            self.fileNameArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let contextItem1 = UIContextualAction(style: .normal, title: "Edit") { contextualAction, view, boolValue in
            print("edit")
        }
        contextItem.image = UIImage(systemName: "multiply.circle.fill")
        contextItem1.image = UIImage(systemName: "multiply.circle.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, contextItem1])

        return swipeActions
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.fileNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        content.text = "Название файла: \(fileNameArray[indexPath.row])"
        content.secondaryText = "Дата создания: \(fileAttributeArray[indexPath.row])"
        cell.contentConfiguration = content
        return cell
    }

}
extension TableViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        do { let documentUrl = try fileManager.url(for: .documentDirectory,
                                                      in: [.userDomainMask],
                                                      appropriateFor: nil,
                                                      create: false)
            let data = tempImage.jpegData(compressionQuality: 1.0)
            var name: Int = 0
            var imagePath = documentUrl.appendingPathComponent(String(name)+".jpg")
            while try! fileManager.fileExists(atPath: imagePath.path) {
                name += 1
                imagePath = documentUrl.appendingPathComponent(String(name)+".jpg")
                print(name)
            }
            try! fileManager.createFile(atPath: imagePath.path, contents: data)
            let attributes = try fileManager.attributesOfItem(atPath: imagePath.path) as NSDictionary
            fileNameArray.append(String(name)+".jpg")
            if self.defaults.bool(forKey: "isSorted") {
                self.fileNameArray = self.fileNameArray.sorted(by: <)
                self.tableView.reloadData()
            } else {
                self.fileNameArray = self.fileNameArray.sorted(by: >)
                self.tableView.reloadData()
            }
            let date = attributes.fileCreationDate()!
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let string = dateFormatter.string(from: date)
            fileAttributeArray.append(string)
            self.tableView.reloadData()
            
        } catch let error {
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false, completion: nil)
    }
}
