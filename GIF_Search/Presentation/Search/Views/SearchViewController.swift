//
//  ViewController.swift
//  GIF_Search
//
//  Created by 동준 on 5/19/24.
//

import UIKit

final class SearchViewController: UIViewController {

    var viewModel = SearchViewModel(giphyService: DefaultGiphyService(apiService: DefaultAPIProvider()))
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    private let searchOutcomeController = SearchOutcomeBoxViewController()
    
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
    
    private func setConstraint() {
        self.searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setSearchController() {
        self.searchController.searchBar.placeholder = "Search Gif"
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    private func setBinding() {
        viewModel.gifURLStorage.bind { [weak self] _ in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                 
            }
        }
    }
    
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchedFor(text: searchText)
    }
}
