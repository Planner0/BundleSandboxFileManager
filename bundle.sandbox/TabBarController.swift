//
//  TabBarController.swift
//  bundle.sandbox
//
//  Created by ALEKSANDR POZDNIKIN on 24.08.2022.
//

import UIKit

class TabBarController: UITabBarController {
    let tableViewController = TableViewController()
    let settingsViewController = SettingsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableNavVC = UINavigationController()
        tableNavVC.pushViewController(tableViewController, animated: true)
        tableNavVC.tabBarItem = UITabBarItem(title: "file list", image: UIImage(systemName: "filemenu.and.selection"), tag: 0)
        let settingsNavVC = UINavigationController()
        settingsNavVC.pushViewController(settingsViewController, animated: true)
        settingsNavVC.tabBarItem = UITabBarItem(title: "settings", image: UIImage(systemName: "gearshape.2.fill"), tag: 0)
        self.viewControllers = [tableNavVC, settingsNavVC]
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
