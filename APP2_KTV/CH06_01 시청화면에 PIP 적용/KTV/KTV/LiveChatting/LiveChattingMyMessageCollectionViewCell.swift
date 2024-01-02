//
//  LiveChattingMyMessageCollectionViewCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/02.
//

import UIKit

class LiveChattingMyMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "LiveChattingMyMessageCollectionViewCell"
    
    private static let sizingCell = Bundle.main.loadNibNamed(
        "LiveChattingMyMessageCollectionViewCell",
        owner: nil
    )?.first(where: { $0 is LiveChattingMyMessageCollectionViewCell }) as? LiveChattingMyMessageCollectionViewCell

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    static func size(width: CGFloat, text: String) -> CGSize {
        Self.sizingCell?.setText(text)
        Self.sizingCell?.frame.size.width = width
        let fittingSize = Self.sizingCell?.systemLayoutSizeFitting(
            .init(width: width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return fittingSize ?? .zero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 8
    }
    
    func setText(_ text: String) {
        self.textLabel.text = text
    }

}
