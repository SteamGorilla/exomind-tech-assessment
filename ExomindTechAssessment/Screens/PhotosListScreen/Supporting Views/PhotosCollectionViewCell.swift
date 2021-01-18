//
//  PhotosCollectionViewCell.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation
import UIKit
import SnapKit

class PhotosCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Elements
    private var thumbnailImage = UIImageView()
    private var plainImage = UIImageView()

    // MARK: - Properties
    var photoData: Photo? {
        didSet {
            setupCellDatas(from: photoData!)
        }
    }

    var thumbnailUrl = String()
    var plainUrl = String()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(thumbnailImage)
    }

    override func layoutSubviews() {
        thumbnailImage.layer.cornerRadius = 15
        thumbnailImage.clipsToBounds = true
    }

    // MARK: - Constraints Setup
    private func setupConstraints() {
        thumbnailImage.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }

    // MARK: - Data Setup
    private func setupCellDatas(from data: Photo) {
        thumbnailUrl = data.thumbnailUrl
        plainUrl = data.url

        imageDownloading()
    }

    func imageDownloading() {
        let url = URL(string: self.thumbnailUrl)!
        do {
            let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
            self.thumbnailImage.image = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

