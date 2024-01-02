//
//  BookmarkCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/02.
//

import UIKit

class BookmarkCell: UITableViewCell {
    
    static let identifier: String = "BookmarkCell"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    private var imageTask: Task<Void, Never>?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.label.text = nil
        self.imageTask?.cancel()
        self.imageTask = nil
        self.thumbnailImageView.image = nil
    }
    
    func setData(_ data: Bookmark.Item) {
        self.label.text = data.channel
        self.imageTask = self.thumbnailImageView.loadImage(url: data.thumbnail)
    }
    
}
