//
//  SettingsTableViewController.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 25.08.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        //self.navigationController!.tabBarItem = UITabBarItem(title: "file list", image: UIImage(systemName: "filemenu.and.selection"), tag: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        switch indexPath.section {
        case 0:
            content.text = "Сортировка"
        case 1:
            content.text = "Поменять пароль"
        default:
            break
        }
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String = ""
        switch section {
        case 0:
            header = "Список файлов"
        case 1:
            header = "Профиль"
        default:
            break
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("tap section one")
            if let cell = tableView.cellForRow(at: indexPath) {
                if cell.contentView.backgroundColor == UIColor.red {
                    cell.contentView.backgroundColor = UIColor.green
                    self.defaults.setValue(true, forKey: "isSorted")
                    print(self.defaults.dictionaryRepresentation())
                } else{
                    cell.contentView.backgroundColor = UIColor.red
                    self.defaults.setValue(false, forKey: "isSorted")
                    print(self.defaults.dictionaryRepresentation())
                }
            }
        case 1:
            print("tap section two")
            let vc = ViewController()
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            print("tap section one")
//            if let cell = tableView.cellForRow(at: indexPath) {
//                cell.contentView.backgroundColor = UIColor.green
//                    }
//        case 1:
//            print("tap section two")
//        default:
//            break
//        }
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
