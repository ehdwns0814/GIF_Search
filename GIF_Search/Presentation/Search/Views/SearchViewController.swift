//
//  ViewController.swift
//  GIF_Search
//
//  Created by 동준 on 5/19/24.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    private let containerView = UIView()
    private let searchOutcomeController = SearchOutcomeBoxViewController()
    
    
    // MARK: - Override(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchController()
        self.setConstraint()
        self.setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Method(s)
    
    private func setSearchController() {
        self.searchController.searchBar.placeholder = "Search Gif"
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    private func setBinding() {
        self.viewModel?.gifURLStorage.bind { [weak self] items in
            DispatchQueue.main.async {
                guard let controller = self?.searchOutcomeController else {
                    return
                }

            }
        }
    }
    
    private func setConstraint() {
        self.view.addSubview(self.containerView)
        self.searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.searchedFor(text: searchText)
    }
}
