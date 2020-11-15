//
//  InfoViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var infoTextHeader: UILabel = {
        let label = UILabel()
        label.text = String(describing: infoText.header)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    private lazy var infoTextMain: UITextView = {
        let tf = UITextView()
        tf.showsVerticalScrollIndicator = true
        tf.textAlignment = .left
        tf.isEditable = false
        tf.isScrollEnabled = true
        tf.text = String(describing: infoText.mainText)
        tf.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return tf
    }()
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubviews(
            infoTextHeader,
            infoTextMain
        )
        
        let constraints = [
            infoTextHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            infoTextHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            infoTextMain.topAnchor.constraint(equalTo: infoTextHeader.bottomAnchor, constant: 16),
            infoTextMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            infoTextMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            infoTextMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        view.backgroundColor = .white
        
        title = "Информация"
    }
}
