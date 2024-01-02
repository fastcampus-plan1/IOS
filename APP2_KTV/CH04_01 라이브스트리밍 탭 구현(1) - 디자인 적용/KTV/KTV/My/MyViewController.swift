//
//  MyViewController.swift
//  KTV
//
//  Created by Lecture on 2023/09/02.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileImageView.layer.cornerRadius = 5
    }

    @IBAction func bookmarkDidTap(_ sender: Any) {
//        self.performSegue(withIdentifier: "bookmark", sender: nil)
    }
    
    @IBAction func favoriteDidTap(_ sender: Any) {
        self.performSegue(withIdentifier: "favorite", sender: nil)
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
