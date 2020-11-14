//
//  InfoViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class InfoViewController: UIViewController {    
    private lazy var infoTextHeader: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    private lazy var infoTextMain: UITextView = {
        let tf = UITextView()
        tf.toAutoLayout()
        tf.scrollRectToVisible(.infinite, animated: true)
        tf.alwaysBounceVertical = true
        tf.showsVerticalScrollIndicator = true
        tf.textAlignment = .left
        tf.isUserInteractionEnabled = true
        tf.text = infoText.init().mainText
        tf.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        view.backgroundColor = .white
        
        title = "Информация"

    }
    
    private func setupLayout() {
        view.addSubview(infoTextHeader)
        view.addSubview(infoTextMain)
        
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
}
