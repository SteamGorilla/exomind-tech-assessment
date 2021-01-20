//
//  AlbumsListViewController.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation
import UIKit
import SnapKit

class AlbumsListViewController: UIViewController {

    // MARK: - UI Elements
    var albumsListCollectionView = UICollectionView(withFlowLayout: true)

    // MARK: - Properties
    private var viewModel: AlbumsListViewModel
    private var userId: Int
    private var name: String

    // MARK: - Initialization
    init(userId: Int, name: String, viewModel: AlbumsListViewModel) {
        self.userId = userId
        self.name = name
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
        viewModel.getAlbums(with: userId)
    }

    // MARK: - UI setup
    private func setupUI() {
        self.view.backgroundColor = .white

        navigationItem.title = "\(name)'s albums"
        navigationItem.largeTitleDisplayMode = .never

        // Albums CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical

        albumsListCollectionView.setCollectionViewLayout(layout, animated: true)

        albumsListCollectionView.delegate = self
        albumsListCollectionView.dataSource = self
        albumsListCollectionView.backgroundColor = .white
        albumsListCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumCollectionViewCell")

        view.addSubview(albumsListCollectionView)
    }

    // MARK: - Constraints setup
    private func setupConstraints() {
        albumsListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Observers setup
    private func setupObservers () {
        viewModel.albums.bind(self) { [weak self] albums in
            print(albums)

            DispatchQueue.main.async {
                self?.albumsListCollectionView.reloadData()
            }
        }
    }
}

// MARK: - CollectionView DataSource
extension AlbumsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albums.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        albumCell.backgroundColor = .white
        albumCell.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        albumCell.layer.borderWidth = 1
        albumCell.layer.cornerRadius = 15
        albumCell.setShadow()

        albumCell.albumData = viewModel.albums.value[indexPath.item]

        return albumCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photosViewModel = PhotosListViewModel()
        self.navigationController?.pushViewController(PhotosListViewController(albumId: viewModel.albums.value[indexPath.item].id,
                                                                               viewModel: photosViewModel), animated: true)
    }
}

// MARK: - CollectionView Layout
extension AlbumsListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 160.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    }
}
