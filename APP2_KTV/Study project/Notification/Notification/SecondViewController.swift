//
//  SecondViewController.swift
//  Notification
//
//  Created by Lecture on 2023/09/21.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationReceived(_:)),
            name: .first,
            object: nil
        )
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let value = notification.userInfo?["value"] as? Int else {
            return
        }
        
        print("notification did received \(value) \(notification.name)")
    }
    
    @IBAction func notifySecond(_ sender: Any) {
        NotificationCenter.default.post(
            name: .second,
            object: self,
            userInfo: [
                "value": 2
            ]
        )
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
