//
//  TabBarController.swift
//  TNU.STUDENTS
//
//  Created by mac on 2/4/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        print("")
        //tabBar.standardAppearance.backgroundColor = Colors.bottomTabBar
        tabBar.backgroundColor = Colors.coursesListItem
        tabBar.barTintColor = Colors.coursesListItem
        
        //tabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: tabBar.frame.height + 50 )
        //tabBar.frame.size.height = tabBar.frame.height + 20
        //tabBar.frame.origin.y = tabBar.frame.origin.y - 20
        
        
    }
}
