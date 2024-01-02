//
//  HomeRecentWatchContainerCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/09.
//

import UIKit

protocol HomeRecentWatchContainerCellDelegate: AnyObject {
    
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int)
}

class HomeRecentWatchContainerCell: UITableViewCell {

    static let identifier: String = "HomeRecentWatchContainerCell"
    static let height: CGFloat = 209
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeRecentWatchContainerCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        
        self.collectionView.register(
            UINib(nibName: HomeRecentWatchItemCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecentWatchItemCell.identifier
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeRecentWatchContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRecentWatchItemCell.identifier,
            for: indexPath
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRecentWatchContainerCell(self, didSelectItemAt: indexPath.item)
    }
}
