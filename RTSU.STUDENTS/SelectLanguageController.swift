//
//  SelectLanguageController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class SelectLanguageController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        
        
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Тоҷики"
            if UserDefaults.standard.string(forKey: "AppLanguage") == "tg" {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
            else {
                cell.accessoryType = .none
            }
        }
        if indexPath.row == 1 {
            cell.textLabel?.text = "Русский"
            if UserDefaults.standard.string(forKey: "AppLanguage") == "ru" {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            UserDefaults.standard.set("tg", forKey: "AppLanguage")
        } else if indexPath.row == 1 {
            UserDefaults.standard.set("ru", forKey: "AppLanguage")
        }
        
        UserDefaults.standard.set([UserDefaults.standard.string(forKey: "AppLanguage")], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        
        //dismiss(animated: true, completion: nil)
        //NotificationCenter.default.post(name: NSNotification.Name("changeImage"), object: nil)
        exit(0)
    }
    
}
