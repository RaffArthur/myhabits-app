//
//  HabitCollectionViewCell.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 15.11.2020.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var habit: Habit? {
        didSet {
            guard let habit = habit else { return }
            
            configure(habit)
        }
    }
    private lazy var habitHeaderText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var habitTimeText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "silver")

        
        return label
    }()
    private lazy var habitTimeIntervalText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(named: "silver_mid")

        
        return label
    }()
    lazy var habitProgressCircle: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .none
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    // MARK: - Configures
    func configure(_ habit: Habit) {
        habitHeaderText.text = habit.name
        habitHeaderText.textColor = habit.color
        habitTimeText.text = habit.dateString
        habitTimeIntervalText.text = String("Подряд \(habit.trackDates.count)")
        
        if habit.isAlreadyTakenToday {
            habitProgressCircle.tintColor = habit.color
            habitProgressCircle.alpha = 1
            habitProgressCircle.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            habitProgressCircle.tintColor = habit.color
            habitProgressCircle.alpha = 1
            habitProgressCircle.image = UIImage(systemName: "circle")
        }
    }
    
    // MARK: - Subviews Funcs
    func setupLayout() {
        contentView.addSubviews(habitHeaderText,
                                habitTimeText,
                                habitTimeIntervalText,
                                habitProgressCircle)

        let constraints = [
            habitHeaderText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitHeaderText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitHeaderText.trailingAnchor.constraint(equalTo: habitProgressCircle.trailingAnchor, constant: -40),

            habitTimeText.topAnchor.constraint(equalTo: habitHeaderText.bottomAnchor, constant: 4),
            habitTimeText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitTimeIntervalText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            habitTimeIntervalText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitProgressCircle.heightAnchor.constraint(equalToConstant: 36),
            habitProgressCircle.widthAnchor.constraint(equalToConstant: 36),
            habitProgressCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            habitProgressCircle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            habitProgressCircle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
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
