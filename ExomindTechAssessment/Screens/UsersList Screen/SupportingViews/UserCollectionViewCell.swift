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
    let fullName = UILabel()
    private let username = UILabel()
    private let email = UILabel()
    private let phoneNumber = UILabel()
    private let website = UILabel()

    // MARK: - Properties
    private var userID: Int?
    var userData: User? {
        didSet {
            setupCellDatas(from: userData!)
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)

        // self.userID = userID
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupUI() {

        // Full Name Label
        // fullName.text = "John Doe"
        fullName.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)
        fullName.textColor = .black
        fullName.translatesAutoresizingMaskIntoConstraints = false
        fullName.adjustsFontSizeToFitWidth = false
        fullName.numberOfLines = 0
        self.addSubview(fullName)

        // Username Label
        // username.text = "j.doe"
        username.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        username.textColor = .black
        username.translatesAutoresizingMaskIntoConstraints = false
        username.adjustsFontSizeToFitWidth = false
        username.numberOfLines = 0
        self.addSubview(username)

        // Email Label
        // email.text = "j.doe@icloud.com"
        email.font = UIFont(name: "HelveticaNeue", size: 16.0)
        email.textColor = .black
        email.translatesAutoresizingMaskIntoConstraints = false
        email.adjustsFontSizeToFitWidth = false
        email.numberOfLines = 0
        self.addSubview(email)

        // Phone Number Label
        // phoneNumber.text = "010-692-6593 x09125"
        phoneNumber.font = UIFont(name: "HelveticaNeue", size: 16.0)
        phoneNumber.textColor = .black
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.adjustsFontSizeToFitWidth = false
        phoneNumber.numberOfLines = 0
        self.addSubview(phoneNumber)

        // Website Label
        // website.text = "hildegard.org"
        website.font = UIFont(name: "HelveticaNeue", size: 16.0)
        website.textColor = .black
        website.translatesAutoresizingMaskIntoConstraints = false
        website.adjustsFontSizeToFitWidth = false
        website.numberOfLines = 0
        self.addSubview(website)
    }

    // MARK: - Constraints Setup
    private func setupConstraints() {
        fullName.snp.makeConstraints {
            $0.top.equalTo(18.0)
            $0.left.equalTo(15.0)
        }

        username.snp.makeConstraints {
            $0.top.equalTo(fullName.snp.bottom).offset(5.0)
            $0.left.equalTo(15.0)
        }

        email.snp.makeConstraints {
            $0.top.equalTo(username.snp.bottom).offset(5.0)
            $0.left.equalTo(15.0)
        }

        phoneNumber.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(5.0)
            $0.left.equalTo(15.0)
        }

        website.snp.makeConstraints {
            $0.top.equalTo(phoneNumber.snp.bottom).offset(5.0)
            $0.left.equalTo(15.0)
        }
    }

    // MARK: - Data Setup
    private func setupCellDatas(from data: User) {
        userID = data.id
        fullName.text = data.name
        username.text = data.username
        email.text = data.email.lowercased()
        phoneNumber.text = data.phone
        website.text = data.website
    }
}
