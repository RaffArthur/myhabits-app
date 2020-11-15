//
//  HabitViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 15.11.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var cancelButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Отменить"
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(cancelHabitCreation)

        return bbi
    }()
    private lazy var createButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Cохранить"
        bbi.style = .done
        bbi.target = self
        bbi.action = #selector(addTheCreatedHabit)

        return bbi
    }()
    private lazy var habitView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var nameInputHeader: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Название".uppercased()
        
        return label
    }()
    private lazy var nameInputField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return tf
    }()
    private lazy var colorSelectionHeader: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Цвет".uppercased()
        
        return label
    }()
    private lazy var colorSelection: UIColorWell = {
        let cw = UIColorWell(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cw.selectedColor = .orange
        cw.isUserInteractionEnabled = true
//        cw.addTarget(self, action: #selector(nil), for: .touchUpInside)
        
        return cw
    }()
    private lazy var timeSelectionHeader: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Время".uppercased()
        
        return label
    }()
    private lazy var timeSelectionSubheader: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Каждый день в"
        
        return label
    }()
    private lazy var timeSelection: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.timeZone = .current
        
        return dp
    }()
    
    // MARK: - @objc Actions
    @objc func cancelHabitCreation() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addTheCreatedHabit() {
        guard let name = nameInputField.text else { return }
        guard let color = colorSelection.selectedColor else { return }
        let date = timeSelection.date
        
        let newHabit = Habit(name: name,
                             date: date,
                             color: color)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
                
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubviewWithAutoLayout(habitView)
        habitView.addSubviews(nameInputHeader,
                              nameInputField,
                              colorSelectionHeader,
                              colorSelection,
                              timeSelectionHeader,
                              timeSelectionSubheader,
                              timeSelection)
            
        let constraints = [
            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            nameInputHeader.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 22),
            nameInputHeader.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),

            nameInputField.topAnchor.constraint(equalTo: nameInputHeader.bottomAnchor, constant: 7),
            nameInputField.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),

            colorSelectionHeader.topAnchor.constraint(equalTo: nameInputField.bottomAnchor, constant: 15),
            colorSelectionHeader.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),

            colorSelection.topAnchor.constraint(equalTo: colorSelectionHeader.bottomAnchor, constant: 7),
            colorSelection.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),

            timeSelectionHeader.topAnchor.constraint(equalTo: colorSelection.bottomAnchor, constant: 15),
            timeSelectionHeader.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),
            
            timeSelectionSubheader.topAnchor.constraint(equalTo: timeSelectionHeader.bottomAnchor, constant: 7),
            timeSelectionSubheader.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),
            timeSelectionSubheader.bottomAnchor.constraint(equalTo: habitView.bottomAnchor, constant: -15),
            
            timeSelection.leadingAnchor.constraint(equalTo: timeSelectionSubheader.trailingAnchor, constant: 16),
            timeSelection.centerYAnchor.constraint(equalTo: timeSelectionSubheader.centerYAnchor)
            
        ]

        NSLayoutConstraint.activate(constraints)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = createButton
        
        navigationItem.title = "Создать"
    }
}
