//
//  TransitionViewController.swift
//  ModalTransitionStyle
//
//  Created by Lecture on 2023/09/20.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func dismiss(_ sender: Any) {
        if self.modalTransitionStyle == .partialCurl {
            self.dismiss(animated: false)
        } else {
            self.dismiss(animated: true)
        }
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
