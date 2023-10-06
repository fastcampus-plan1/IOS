//
//  ViewController.swift
//  ModalPresentation
//
//  Created by Lecture on 2023/09/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(self)", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self)", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("\(self)", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("\(self)", #function)
    }

    @IBAction func fullscreenDidTap(_ sender: Any) {
        let vc = ModalViewController()
        // present하기전 세팅이 완료되어있어야함
        // 일반적으로 viewDidLoad가 불리기전인 initializer 혹은 vc 인스턴스를 생성하고 나서 처리.
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func pageSheetDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    @IBAction func overfullscreenDidTap(_ sender: Any) {
        let vc = ModalViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

