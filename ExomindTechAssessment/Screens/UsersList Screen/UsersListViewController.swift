//
//  UsersListViewController.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 12/01/2021.
//

import UIKit
import SnapKit

class UsersListViewController: UIViewController {

    // MARK: - UI Elements
    private var usersListCollectionView = UICollectionView(withFlowLayout: true)

    // MARK: - Properties
    private var viewModel: UsersListViewModel
    private lazy var filtered: [User] = []
    private var searchActive: Bool = false
    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - Initialization
    init(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupObservers()

        if UserDefaults.standard.data(forKey: "users") != nil {
            viewModel.setStoredUsers()
        } else {
            viewModel.getUsers()
        }

        filtered = viewModel.users.value
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = .white

        // SearchBar
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for an user"
        searchController.searchBar.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 60)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        searchController.searchBar.becomeFirstResponder()

        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Users"

        // Users CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .vertical

        usersListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        usersListCollectionView.delegate = self
        usersListCollectionView.dataSource = self
        usersListCollectionView.backgroundColor = .white
        usersListCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "UserCollectionViewCell")

        view.addSubview(usersListCollectionView)
    }

    // MARK: - Constraints setup
    private func setupConstraints() {

    }

    // MARK: - Observers setup
    private func setupObservers() {
        viewModel.users.bind(self) { [weak self] users in
            print(users)

            DispatchQueue.main.async {
                self?.usersListCollectionView.reloadData()
            }
        }
    }
}

// MARK: - CollectionView DataSource
extension UsersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        } else {
            return viewModel.users.value.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        userCell.backgroundColor = .white
        userCell.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        userCell.layer.borderWidth = 1
        userCell.layer.cornerRadius = 15
        userCell.setShadow()

        if filtered.isEmpty {
            userCell.userData = viewModel.users.value[indexPath.item]
        } else {
            userCell.userData = filtered[indexPath.item]
        }

        return userCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumsViewModel = AlbumsListViewModel()

        if filtered.isEmpty {
            self.navigationController?.pushViewController(AlbumsListViewController(userId: viewModel.users.value[indexPath.item].id,
                                                                                   name: viewModel.users.value[indexPath.item].name,
                                                                                   viewModel: albumsViewModel), animated: true)
        } else {
            self.navigationController?.pushViewController(AlbumsListViewController(userId: filtered[indexPath.item].id,
                                                                                   name: filtered[indexPath.item].name,
                                                                                   viewModel: albumsViewModel), animated: true)
        }
    }
}

// MARK: - CollectionView Layout
extension UsersListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 160.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    }
}

// MARK: - SearchBar Results
extension UsersListViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            self.dismiss(animated: true, completion: nil)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        filtered = viewModel.users.value

        if searchString.count >= 2 {
            filtered = viewModel.users.value.filter({ $0.name.contains(searchString) })
        }

        usersListCollectionView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        usersListCollectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        usersListCollectionView.reloadData()
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            usersListCollectionView.reloadData()
        }

        searchController.searchBar.resignFirstResponder()
    }
}
