//
//  ComposeCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by Lecture on 2023/09/17.
//

import UIKit

class ComposeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.label.text = nil
    }
    
    func setIndexPath(_ indexPath: IndexPath) {
        self.label.text = "\(indexPath.section), \(indexPath.item)"
    }

}
