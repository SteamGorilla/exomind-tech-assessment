//
//  PhotosListViewController.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation
import UIKit
import SnapKit

class PhotosListViewController: UIViewController {

    // MARK: - UI Elements
    private var photosListCollectionView = UICollectionView(withFlowLayout: true)

    // MARK: - Properties
    private var viewModel: PhotosListViewModel
    private var albumId: Int

    // MARK: - Initialization
    init(albumId: Int, viewModel: PhotosListViewModel) {
        self.albumId = albumId
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
        viewModel.getPhotos(with: albumId)
    }

    // MARK: - UI setup
    private func setupUI() {
        self.view.backgroundColor = .white

        navigationItem.title = "Photos"
        navigationItem.largeTitleDisplayMode = .never

        // Photos CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical

        photosListCollectionView.setCollectionViewLayout(layout, animated: true)

        photosListCollectionView.delegate = self
        photosListCollectionView.dataSource = self
        photosListCollectionView.backgroundColor = .white
        photosListCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")

        view.addSubview(photosListCollectionView)
    }

    // MARK: - Constraints setup
    private func setupConstraints() {
        photosListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Observers setup
    private func setupObservers () {
        viewModel.photos.bind(self) { [weak self] photos in
            print(photos)

            DispatchQueue.main.async {
                self?.photosListCollectionView.reloadData()
            }
        }
    }
}

// MARK: - CollectionView DataSource
extension PhotosListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }

        photoCell.backgroundColor = .white
        photoCell.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        photoCell.layer.borderWidth = 1
        photoCell.layer.cornerRadius = 15
        photoCell.setShadow()

        photoCell.photoData = viewModel.photos.value[indexPath.item]

        return photoCell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotosCollectionViewCell else { return }
        let itemNumber = NSNumber(value: indexPath.item)

        if let cachedImage = self.viewModel.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
                cell.thumbnailImage.image = cachedImage
            } else {
                self.viewModel.loadImage(with: self.viewModel.photos.value[indexPath.item].thumbnailUrl) { [weak self] (image) in
                    guard let self = self, let image = image else { return }
                    cell.thumbnailImage.image = image
                    self.viewModel.cache.setObject(image, forKey: itemNumber)
                }
            }
    }
}

// MARK: - CollectionView Layout
extension PhotosListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 160.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    }
}
