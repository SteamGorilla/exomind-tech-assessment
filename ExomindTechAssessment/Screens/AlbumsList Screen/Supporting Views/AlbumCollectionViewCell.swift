//
//  AlbumCollectionViewCell.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 18/01/2021.
//

import Foundation
import UIKit
import SnapKit

class AlbumCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Elements
    private let albumTitle = UILabel()

    // MARK: - Properties
    var albumData: Album? {
        didSet {
            setupCellDatas(from: albumData!)
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

    // MARK: - UI Setup
    private func setupUI() {
        albumTitle.font = UIFont(name: "HelveticaNeue", size: 16.0)
        albumTitle.textColor = .black
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        albumTitle.adjustsFontSizeToFitWidth = false
        albumTitle.numberOfLines = 0
        self.addSubview(albumTitle)
    }

    // MARK: - Constraints Setup
    private func setupConstraints() {
        albumTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20.0)
        }
    }

    // MARK: - Data Setup
    private func setupCellDatas(from data: Album) {
        albumTitle.text = data.title
    }
}
