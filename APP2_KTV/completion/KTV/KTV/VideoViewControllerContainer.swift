//
//  VideoViewControllerContainer.swift
//  KTV
//
//  Created by Lecture on 2023/09/22.
//

import Foundation

protocol VideoViewControllerContainer {
    var videoViewController: VideoViewController? { get }
    func presentCurrentViewController()
}
