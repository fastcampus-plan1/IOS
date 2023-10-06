//
//  ViewController.swift
//  ModalTransitionStyle
//
//  Created by Lecture on 2023/09/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func coverVertical(_ sender: Any) {
        let vc = TransitionViewController()
        self.present(vc, animated: true)
    }
    
    @IBAction func flipHorizontal(_ sender: Any) {
        let vc = TransitionViewController()
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    @IBAction func crossDissolve(_ sender: Any) {
        let vc = TransitionViewController()
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    @IBAction func partialCurl(_ sender: Any) {
        let vc = TransitionViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .partialCurl
        self.present(vc, animated: true)
    }
}

