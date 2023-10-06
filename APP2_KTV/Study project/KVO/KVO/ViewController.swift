//
//  ViewController.swift
//  KVO
//
//  Created by Lecture on 2023/09/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    private let object = KVOObject()
    private var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observe의 return value인 NSKeyValueObservation를 반드시 retain하여야함.
        self.observation = self.object.observe(
            \.value,
             options: [.new],
             changeHandler: { [weak self] _, change in
                 guard let value = change.newValue else {
                     return
                 }
                 self?.label.text = "\(value)"
             }
        )
    }

    @IBAction func stpperDidTap(_ sender: UIStepper) {
        self.object.value = Int(sender.value)
    }
    
}

