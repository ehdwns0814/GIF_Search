//
//  SearchOutcomeBoxViewController.swift
//  GIF_Search
//
//  Created by 동준 on 5/28/24.
//

import UIKit

protocol SearchOutcomeBoxViewControllerDelegate: AnyObject {
    func selectQuery(_ item: SearchItem)
    func ScrollEndReached()
}

class SearchOutcomeBoxViewController: UIViewController {
    
    // MARK: - Variable(s)
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchSection, SearchItem>?
    private var snapShot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()
    private var searchOutcomeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Initializer(s)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubviews()
        self.setHierarchy()
        self.setConstraint()
    }
    
    // MARK: - Method(s)
    
    func appendSearchOutcomesSnapshot(items: [SearchItem], for section: SearchSection) {
        self.snapShot.appendItems(items, toSection: section)
        self.searchOutcomeCollectionView.collectionViewLayout = createSearchOutcomeCollectionViewLayout()
        self.dataSource?.apply(self.snapShot)
    }
    
    // MARK: - Private Method(s)
    
    private func setSubviews() {
        self.setSearchOutcomeCollectionView()
    }
    
    private func setHierarchy() {
        self.view.addSubview(self.searchOutcomeCollectionView)
    }
    
    private func setConstraint() {
        self.searchOutcomeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.searchOutcomeCollectionView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            self.searchOutcomeCollectionView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor
            ),
            self.searchOutcomeCollectionView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            self.searchOutcomeCollectionView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func createSearchOutcomeCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setSearchOutcomeCollectionView() {
        self.searchOutcomeCollectionView.delegate = self
        self.dataSource = self.createSearchResultDataSource()
        self.searchOutcomeCollectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: "imageCell"
        )
        self.snapShot.appendSections([SearchSection.searchResult])
    }
    
    private func createSearchResultDataSource() -> UICollectionViewDiffableDataSource<SearchSection, SearchItem> {
        return UICollectionViewDiffableDataSource<SearchSection, SearchItem>(
            collectionView: self.searchOutcomeCollectionView
        ) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionViewCell.identifier,
                for: indexPath
            ) as? ImageCollectionViewCell else {
                return nil
            }
            switch itemIdentifier {
            case .image(let imageItemViewModel):
                cell.configureContent(imageItemViewModel)
            }
            return cell
        }
    }
}
