//
//  ViewController.swift
//  Notification
//
//  Created by Lecture on 2023/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationReceived(_:)),
            name: .second,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .second, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let value = notification.userInfo?["value"] as? Int else {
            return
        }
        
        print("notification did received \(value) \(notification.name)")
    }

    @IBAction func notifyFirst(_ sender: UIButton) {
        NotificationCenter.default.post(
            name: .first,
            object: self,
            userInfo: [
                "value": 1
            ]
        )
    }
    
}

