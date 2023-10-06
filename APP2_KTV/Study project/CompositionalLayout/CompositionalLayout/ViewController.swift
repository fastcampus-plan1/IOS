//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Lecture on 2023/09/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ComposeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ComposeCollectionViewCell")
        self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            
            let leftItem = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
            )
            leftItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let rightItem = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.5)
                )
            )
            rightItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let rightGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                ),
                subitems: [rightItem]
            )
            
            
            let group1 = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(200)
                ),
                subitems: [leftItem, rightGroup]
            )
            
            let section = NSCollectionLayoutSection(group: group1)
            section.interGroupSpacing = 5
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComposeCollectionViewCell", for: indexPath)
        (cell as? ComposeCollectionViewCell)?.setIndexPath(indexPath)
        
        return cell
    }

}

