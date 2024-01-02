//
//  HomeRecommendViewModel.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import Foundation

class HomeRecommendViewModel {
    
    private(set) var isFolded: Bool = true {
        didSet {
            self.foldChanged?(self.isFolded)
        }
    }
    
    var foldChanged: ((Bool) -> Void)?
    var recommends: [VideoListItem]?
    var itemCount: Int {
        let count = self.isFolded ? 5 : self.recommends?.count ?? 0
        
        return min(self.recommends?.count ?? 0, count)
    }
    
    func toggleFoldState() {
        self.isFolded.toggle()
    }
}
