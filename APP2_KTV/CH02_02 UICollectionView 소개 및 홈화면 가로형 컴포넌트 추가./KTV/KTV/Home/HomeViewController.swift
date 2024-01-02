//
//  HomeViewController.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let homeViewModel: HomeViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(
            UINib(nibName: "HomeHeaderCell", bundle: .main),
            forCellReuseIdentifier: HomeHeaderCell.identifier
        )
        self.tableView.register(
            UINib(nibName: "HomeVideoCell", bundle: .main),
            forCellReuseIdentifier: HomeVideoCell.identifier
        )
        self.tableView.register(
            UINib(nibName: "HomeRecommendContainerCell", bundle: .main),
            forCellReuseIdentifier: HomeRecommendContainerCell.identifier
        )
        self.tableView.register(
            UINib(nibName: "HomeFooterCell", bundle: .main),
            forCellReuseIdentifier: HomeFooterCell.identifier
        )
        self.tableView.register(
            UINib(nibName: HomeRankingContainerCell.identifier, bundle: nil),
            forCellReuseIdentifier: HomeRankingContainerCell.identifier
        )
        
        self.tableView.register(
            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeRecentWatchContainerCell.identifier
        )
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 1
        case .video:
            return 2
        case .ranking:
            return 1
        case .recentWatch:
            return 1
        case .recommend:
            return 1
        case .footer:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return 0
        }
        switch section {
        case .header:
            return HomeHeaderCell.height
        case .video:
            return HomeVideoCell.height
        case .ranking:
            return HomeRankingContainerCell.height
        case .recentWatch:
            return HomeRecentWatchContainerCell.height
        case .recommend:
            return HomeRecommendContainerCell.height
        case .footer:
            return HomeFooterCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        switch section {
        case .header:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeHeaderCell.identifier,
                for: indexPath
            )
        case .video:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
        case .ranking:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )
            
            (cell as? HomeRankingContainerCell)?.delegate = self
            
            return cell
        case .recentWatch:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )
            
            (cell as? HomeRecentWatchContainerCell)?.delegate = self
            
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            
            (cell as? HomeRecommendContainerCell)?.delegate = self
            
            return cell
        case .footer:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeFooterCell.identifier,
                for: indexPath
            )
        }
    }
}

extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
    }
}

extension HomeViewController: HomeRankingContainerCellDeleate {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int) {
        print("home ranking did select at \(index)")
    }
}

extension HomeViewController: HomeRecentWatchContainerCellDelegate {
    
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int) {
        print("home recent watch did select at \(index)")
    }
}
