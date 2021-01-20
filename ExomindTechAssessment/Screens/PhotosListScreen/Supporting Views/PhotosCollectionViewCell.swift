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
    var thumbnailImage = UIImageView()

    // MARK: - Properties
    var thumbnailUrl = String()

    var photoData: Photo? {
        didSet {
            setupCellDatas(from: photoData!)
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.thumbnailImage.image = nil
    }

    // MARK: - UI Setup
    private func setupUI() {
        thumbnailImage.contentMode = .scaleAspectFit
        thumbnailImage.layer.cornerRadius = 15
        thumbnailImage.clipsToBounds = true
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(thumbnailImage)
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
    }
}
