//
//  HabitCollectionViewCell.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 15.11.2020.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private var habit: Habit? {
        didSet {
            guard let habit = habit else { return }
            
            configure(habit)
        }
    }
    private lazy var habitHeaderText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
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
    private lazy var habitProgressCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        
        return view
    }()
    
    // MARK: - Subviews Funcs
    func setupLayout() {
        contentView.addSubviews(habitHeaderText,
                                habitTimeText,
                                habitTimeIntervalText,
                                habitProgressCircle)

        let constraints = [
            habitHeaderText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitHeaderText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitTimeText.topAnchor.constraint(equalTo: habitHeaderText.bottomAnchor, constant: 4),
            habitTimeText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitTimeIntervalText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            habitTimeIntervalText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            habitProgressCircle.heightAnchor.constraint(equalToConstant: 36),
            habitProgressCircle.widthAnchor.constraint(equalToConstant: 36),
            habitProgressCircle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            habitProgressCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            habitProgressCircle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        habitProgressCircle.layer.cornerRadius = habitProgressCircle.frame.height / 2

        setupLayout()
        print(HabitsStore.shared.habits.count)

        backgroundColor = .white
        layer.cornerRadius = 8
    }
    
    func configure(_ habit: Habit) {
        habitHeaderText.text = habit.name
        habitHeaderText.textColor = habit.color
        habitTimeText.text = habit.dateString
        habitTimeIntervalText.text = String("Подряд \(habit.trackDates.count)")
        habitProgressCircle.layer.borderColor = habit.color.cgColor
    }
}
