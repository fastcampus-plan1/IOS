//
//  NavigationController.swift
//  KTV
//
//  Created by Lecture on 2023/09/17.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        self.topViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
