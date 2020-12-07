//
//  SelectSemesterController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/13/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class SelectSemesterController: UITableViewController {
    
    //@IBOutlet weak var navigationBar: UINavigationBar!
    //@IBOutlet weak var semestersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //semestersTable.delegate = self
        //semestersTable.dataSource = self
        
        //let backItem = UIBarButtonItem()
        //backItem.title = "Back"
        
       // let bounds = navigationBar.bounds
        //navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 50.0)
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentData.semesters?.count ?? 0
    }
    
    var poss: IndexPath? = nil
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "semesterCell", for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = StudentData.semesters?[row].AcademicYear
        cell.isSelected = false
        cell.accessoryType = UITableViewCell.AccessoryType.none
        
        
        if StudentData.semesters?[row].isActive == true {
            print(StudentData.semesters?[row].AcademicYear ?? "")
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            poss = indexPath
        }
        
        return cell
    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if poss != nil {
            tableView.cellForRow(at: poss!)?.accessoryType = UITableViewCell.AccessoryType.none
            StudentData.semesters?[poss?.row ?? 0].isActive = false
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        poss = indexPath
        StudentData.semesters?[indexPath.row].isActive = true
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateCourses"), object: nil)
        
    }
    
    
}
