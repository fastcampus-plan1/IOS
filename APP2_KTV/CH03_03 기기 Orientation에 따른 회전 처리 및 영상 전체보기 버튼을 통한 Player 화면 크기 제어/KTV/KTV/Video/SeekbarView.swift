//
//  SeekbarView.swift
//  KTV
//
//  Created by Lecture on 2023/09/21.
//

import UIKit

protocol SeekBarViewDelegate: AnyObject {
    
    func seekbar(_ seekbar: SeekbarView, seekToPercent percent: Double)
}

class SeekbarView: UIView {

    @IBOutlet weak var totalPlayTimeView: UIView!
    @IBOutlet weak var playablePlayTimeView: UIView!
    @IBOutlet weak var currentPlayTimeView: UIView!
    @IBOutlet weak var playableTimeWidth: NSLayoutConstraint!
    @IBOutlet weak var playTimeWidth: NSLayoutConstraint!
    
    private(set) var totalPlayTime: Double = 0
    private(set) var playableTime: Double = 0
    private(set) var currentPlayTime: Double = 0
    
    weak var delegate: SeekBarViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.totalPlayTimeView.layer.cornerRadius = 1
        self.playablePlayTimeView.layer.cornerRadius = 1
        self.currentPlayTimeView.layer.cornerRadius = 1
    }
    
    func setTotalPlayTime(_ totalPlayTime: Double) {
        self.totalPlayTime = totalPlayTime
        
        self.update()
    }
    
    func setPlayTime(_ playTime: Double, playableTime: Double) {
        self.currentPlayTime = playTime
        self.playableTime = playableTime
        
        self.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        self.updatePlayedWidth(touch: touch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        self.updatePlayedWidth(touch: touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        self.updatePlayedWidth(touch: touch)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        self.updatePlayedWidth(touch: touch)
    }
    
    private func updatePlayedWidth(touch: UITouch) {
        let xPosition = self.widthForTouch(touch)
        self.playTimeWidth.constant = xPosition
        
        self.delegate?.seekbar(self, seekToPercent: xPosition / self.frame.width)
    }
    
    private func update() {
        guard self.totalPlayTime > 0 else {
            return
        }
        
        self.playableTimeWidth.constant = self.widthForTime(self.playableTime)
        self.playTimeWidth.constant = self.widthForTime(self.currentPlayTime)
        
        UIView.animate(
            withDuration: 0.2
        ) {
            self.layoutIfNeeded()
        }
    }
    
    private func widthForTime(_ time: Double) -> CGFloat {
        min(self.frame.width, self.frame.width * time / self.totalPlayTime)
    }
    
    private func widthForTouch(_ touch: UITouch) -> CGFloat {
        min(touch.location(in: self).x, self.playableTimeWidth.constant)
    }

}
