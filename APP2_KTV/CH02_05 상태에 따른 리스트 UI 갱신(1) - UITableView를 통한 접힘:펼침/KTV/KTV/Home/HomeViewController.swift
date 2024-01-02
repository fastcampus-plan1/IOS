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
        self.bindViewModel()
        self.homeViewModel.requestData()
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
        
        self.tableView.isHidden = true
    }
    
    private func bindViewModel() {
        self.homeViewModel.dataChanged = { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
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
            return self.homeViewModel.home?.videos.count ?? 0
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
            return HomeRecommendContainerCell.height(viewModel: self.homeViewModel.recommendViewModel)
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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeVideoCell,
                let data = self.homeViewModel.home?.videos[indexPath.row] {
                cell.setData(data)
            }
            
            return cell
        case .ranking:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRankingContainerCell,
                let data = self.homeViewModel.home?.rankings {
                cell.setData(data)
            }
            
            (cell as? HomeRankingContainerCell)?.delegate = self
            
            return cell
        case .recentWatch:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRecentWatchContainerCell,
                let data = self.homeViewModel.home?.recents {
                cell.delegate = self
                cell.setData(data)
            }
            
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            
            if let cell = cell as? HomeRecommendContainerCell {
                cell.delegate = self
                cell.setViewModel(self.homeViewModel.recommendViewModel)
            }
            
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

    func homeRecommendContainerCellFoldChanged(_ cell: HomeRecommendContainerCell) {
        self.tableView.reloadData()
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
