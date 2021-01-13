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
    var usersListCollectionView: UICollectionView?

    // MARK: - Properties
    private var viewModel: UsersListViewModel

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
        viewModel.getUsers()
    }

    // MARK: - UI setup
    private func setupUI() {
        view.backgroundColor = .white

        // Users CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.scrollDirection = .vertical

        usersListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        usersListCollectionView?.delegate = self
        usersListCollectionView?.dataSource = self
        usersListCollectionView?.backgroundColor = .white
        usersListCollectionView?.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "cell")


        view.addSubview(usersListCollectionView ?? UICollectionView())
    }

    // MARK: - Constraints setup
    private func setupConstraints() {

    }

    // MARK: - Observers setup
    private func setupObservers() {
        viewModel.users.bind(self) { [weak self] users in
            print(users)
            // Le code que tu mettras ici sera executé dès que la ligne:
            // myData.value = LaDataDuBackEnd
            // dans le viewModel sera exécutée
        }
    }
}

// MARK: - CollectionView Layout
extension UsersListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 350, height: 140.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  20
    }
}

// MARK: - CollectionView DataSource
extension UsersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        userCell.backgroundColor = UIColor.white
        userCell.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        userCell.layer.borderWidth = 1
        userCell.layer.cornerRadius = 15

        userCell.setShadow()

        return userCell
    }
}
