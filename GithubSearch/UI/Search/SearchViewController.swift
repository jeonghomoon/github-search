//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/09.
//

import Combine
import UIKit

final class SearchViewController: UIViewController {
    private enum Attribute {
        static let backgroundColor: UIColor = .white

        static let placeholderImage: UIImage? = UIImage(systemName: "person")

        static let profileImageSize: CGSize = CGSize(width: 24, height: 24)
        
        static let nextPageOffsetY: CGFloat = 40
    }

    private lazy var searchController = UISearchController(
        searchResultsController: nil
    )

    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var dataSource = makeDataSource()

    private let viewModel = SearchViewModel()
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        bindViews()
    }

    private func initViews() {
        view.backgroundColor = Attribute.backgroundColor

        navigationItem.searchController = searchController

        view.addSubview(collectionView)

        activateConstraints()
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            )
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(
            appearance: .plain
        )
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

extension SearchViewController {
    private typealias CellRegistration =
        UICollectionView.CellRegistration<UICollectionViewListCell, UserItem>

    private typealias DataSource =
        UICollectionViewDiffableDataSource<UserSection, UserItem>

    private typealias Snapshot =
        NSDiffableDataSourceSnapshot<UserSection, UserItem>

    private func bindViews() {
        searchController.searchBar.searchTextField.textPublisher
            .sink { [weak self] query in
                Task {
                    try await self?.viewModel.searchUsers(query)
                }
            }.store(in: &cancelBag)

        collectionView.scrollPublisher(util: Attribute.nextPageOffsetY)
            .sink{ [weak self] _ in
                Task {
                    try await self?.viewModel.loadNextPage()
                }
            }.store(in: &cancelBag)

        viewModel.$items
            .sink { [weak self] items in
                self?.applySnapshot(for: items)
            }.store(in: &cancelBag)
    }

    private func registerCell() -> CellRegistration {
        return CellRegistration { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            content.image = item.profileImage ?? Attribute.placeholderImage
            content.imageProperties.maximumSize = Attribute.profileImageSize

            cell.contentConfiguration = content
            cell.backgroundConfiguration = {
                var configuraion = UIBackgroundConfiguration.clear()
                configuraion.backgroundColor = Attribute.backgroundColor
                return configuraion
            }()

            Task {
                try await self.viewModel.fetchImage(
                    in: item,
                    default: Attribute.placeholderImage
                )
            }
        }
    }

    private func makeDataSource() -> DataSource {
        let registraion = registerCell()

        return DataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: registraion,
                for: indexPath,
                item: item
            )
        }
    }

    private func applySnapshot(for items: [UserItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
