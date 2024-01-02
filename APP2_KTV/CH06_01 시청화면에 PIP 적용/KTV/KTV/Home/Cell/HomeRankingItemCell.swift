//
//  HomeRankingItemCell.swift
//  KTV
//
//  Created by Lecture on 2023/08/24.
//

import UIKit

class HomeRankingItemCell: UICollectionViewCell {
    
    static let identifier: String = "HomeRankingItemCell"
    static let size: CGSize = CGSize(width: 130, height: 239)

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    private var imageTask: Task<Void, Never>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.numberLabel.text = nil
        self.thumbnailImageView.image = nil
        self.imageTask?.cancel()
        self.imageTask = nil
    }
    
    func setData(_ data: Home.Ranking, rank: Int) {
        self.numberLabel.text = "\(rank)"
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }

}
