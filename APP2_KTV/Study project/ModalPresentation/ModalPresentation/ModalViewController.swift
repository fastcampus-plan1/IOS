//
//  ModalViewController.swift
//  ModalPresentation
//
//  Created by Lecture on 2023/09/13.
//

import UIKit

class ModalViewController: UIViewController {
    
    var number: Int = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // ViewController를 xib로 만들었을때
        // modal presentation style 설정
        
        print("ModalViewController, \(#function)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // ViewController를 storyboard로 만들었을때
        // modal presentation style 설정
        print("ModalViewController, \(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 해당타이밍에는 ViewController의 presenting이 시작되는 경우가 대부분.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(self)", self.number, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self)", self.number, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("\(self)", self.number, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("\(self)", self.number, #function)
    }

    @IBAction func dismissDidTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func fullScreenDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.number += 1
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func pageSheetDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.number += 1
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    @IBAction func overFullScreenDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.number += 1
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func automaticDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.number += 1
        vc.modalPresentationStyle = .automatic // 기본값이 automatic
        self.present(vc, animated: true)
    }
}
