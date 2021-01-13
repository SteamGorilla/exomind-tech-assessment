//
//  UserCollectionViewCell.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 13/01/2021.
//

import Foundation
import UIKit
import SnapKit

class UserCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Elements
    private let fullName = UILabel()
    private let username = UILabel()
    private let email = UILabel()
    private let phoneNumber = UILabel()
    private let website = UILabel()

    // MARK: - Properties
    //private var userID: Int

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)

        //self.userID = userID
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupUI() {

    }

    // MARK: - Constraints Setup
    private func setupConstraints() {

    }
}

extension UserCollectionViewCell {

}
