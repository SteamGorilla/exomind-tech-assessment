//
//  ViewController.swift
//  ExomindTechAssessment
//
//  Created by Jeremy Papay on 11/01/2021.
//

import UIKit
import SnapKit

// Le `Name` sera sélectionné afin de me permettre de nommé facilement mon nouveau ViewController
class HomeViewController: UIViewController {

    // MARK: - UI Elements
    // C'est ici que j'ajouterai tous mes éléments UI tels que des boutons par exemple
    let label = UILabel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    // MARK: - UI setup
    // C'est dans cette fonction que j'initialise les éléments UI
    private func setupUI() {
        view.backgroundColor = .white

        // Title Label
        label.text = "Hello World"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        view.addSubview(label)
    }

    // MARK: - Constraints setup
    // C'est ici que seront définit les contraintes
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.topMargin.equalTo(45.0)
            $0.leftMargin.equalTo(15.0)
        }
    }
}
