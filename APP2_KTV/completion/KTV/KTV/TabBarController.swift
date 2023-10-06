//
//  TabBarController.swift
//  KTV
//
//  Created by Lecture on 2023/09/13.
//

import UIKit

class TabBarController: UITabBarController, VideoViewControllerContainer, VideoViewControllerDelegate {
    weak var videoViewController: VideoViewController?
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func videoViewController(_ videoViewController: VideoViewController, yPositionForMinizeView height: CGFloat) -> CGFloat {
        return self.tabBar.frame.minY - height
    }
    
    func videoViewControllerDidMinimize(_ videoViewController: VideoViewController) {
        self.videoViewController = videoViewController
        self.addChild(videoViewController)
        self.view.addSubview(videoViewController.view)
        videoViewController.didMove(toParent: self)
    }
    
    func videoViewControllerNeedsMaximize(_ videoViewController: VideoViewController) {
        self.videoViewController = nil
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
    }
    
    func videoViewControllerDidTapClose(_ videoViewController: VideoViewController) {
        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.videoViewController = nil
    }
    
    func presentCurrentViewController() {
        guard let videoViewController else {
            return
        }

        videoViewController.willMove(toParent: nil)
        videoViewController.view.removeFromSuperview()
        videoViewController.removeFromParent()
        
        self.present(videoViewController, animated: true)
        self.videoViewController = nil
    }
}
