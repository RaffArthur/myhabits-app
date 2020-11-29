//
//  ProgressCollectionViewCell.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 15.11.2020.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var habitsStore: HabitsStore? {
        didSet {
            guard let habitsStore = habitsStore else { return }
            
            configure(habitsStore)
        }
    }
    private lazy var progressStatusText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "silver_mid")
        label.text = "Все получится!"
        
        return label
    }()
    private lazy var percentageProgress: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "silver_mid")
        
        return label
    }()
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.backgroundColor = UIColor(named: "silver_light")
        pv.layer.cornerRadius = 4
        pv.layer.masksToBounds = true
        
        return pv
    }()
    
    // MARK: - Configures
    func configure(_ habitsStore: HabitsStore) {
        progressBar.setProgress(habitsStore.todayProgress, animated: true)
        percentageProgress.text = String(describing: "\(Int(habitsStore.todayProgress * 100))%")
    }
    
    // MARK: - Subviews Funcs
    func setupLayout() {
        contentView.addSubviews(progressStatusText,
                                percentageProgress,
                                progressBar)
        
        let constraints = [
            progressStatusText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressStatusText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            progressBar.topAnchor.constraint(equalTo: progressStatusText.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: progressStatusText.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressBar.heightAnchor.constraint(equalToConstant: 7),

            
            percentageProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percentageProgress.centerYAnchor.constraint(equalTo: progressStatusText.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()        
        
        backgroundColor = .white
        layer.cornerRadius = 8
    }
}
