//
//  MoreTableViewCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/01.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    static let identifier: String = "MoreTableViewCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.descriptionLabel.text = nil
        self.titleLabel.text = nil
    }
    
    func setItem(_ item: MoreItem, separatorHidden: Bool) {
        
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.rightText
        self.separatorView.isHidden = separatorHidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
