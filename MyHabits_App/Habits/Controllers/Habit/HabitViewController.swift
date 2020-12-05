//
//  HabitViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 15.11.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    // MARK: - Properties
    var isInEditMode: Bool?
    var habit: HabitWithIndex?
    var habitDetailsVC: HabitDetailsViewController?
    private lazy var cancelButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Отменить"
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(cancelButtonTapped)

        return bbi
    }()
    private lazy var saveButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Cохранить"
        bbi.style = .done
        bbi.target = self
        bbi.action = #selector(saveButtonTapped)

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
        tf.clearButtonMode = .always
        tf.tintColor = UIColor(named: "AccentColor")
        
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
        cw.isUserInteractionEnabled = true
        cw.title = "Выберите цвет привычки"
        cw.supportsAlpha = true
        
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
        dp.timeZone = .autoupdatingCurrent
        
        return dp
    }()
    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.isUserInteractionEnabled = true
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deleteHabitButtonTapped), for: .touchUpInside)
        return button
    }()
        
    // MARK: - @objc Actions
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        guard let name = nameInputField.text else { return }
        guard let color = colorSelection.selectedColor else { return }
        let date = timeSelection.date
        let newHabit = Habit(name: name,
                             date: date,
                             color: color)
        
        if isInEditMode == true {
            guard let habit = habit else { return }
            editHabit(newHabit, atIndex: habit.habitIndex)
        } else {
            let habitsStore = HabitsStore.shared
            habitsStore.habits.append(newHabit)
        }
                        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func deleteHabitButtonTapped() {
        guard let habit = habit else { return }
        
        let alertController = UIAlertController(title: "Удаление привычки",
                                                message: "Вы дествительно хотите удалить привычку \"\(String(describing: habit.customHabit.name))\"",
                                                preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: habit.habitIndex)
            
            self.habitDetailsVC?.navigationController?.popViewController(animated: true)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - EditMode funcs
    func setupEditMode(_ habit: Habit) {
        colorSelection.selectedColor = habit.color
        nameInputField.text = habit.name
        nameInputField.font = .systemFont(ofSize: 20, weight: .bold)
        nameInputField.textColor = .systemBlue
        timeSelection.date = habit.date
    }
    
    private func editHabit(_ habit: Habit, atIndex index: Int) {
        HabitsStore.shared.habits[index].name = habit.name
        HabitsStore.shared.habits[index].date = habit.date
        HabitsStore.shared.habits[index].color = habit.color
    }
    
    // MARK: - Inits
    init(isInEditMode: Bool) {
        self.isInEditMode = isInEditMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View Funcs
    private func setupLayout(_ isInEditMode: Bool) {
        view.addSubviews(habitView,
                         deleteHabitButton)
        habitView.addSubviews(nameInputHeader,
                              nameInputField,
                              colorSelectionHeader,
                              colorSelection,
                              timeSelectionHeader,
                              timeSelectionSubheader,
                              timeSelection
                              )
            
        let constraints = [
            deleteHabitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            nameInputHeader.topAnchor.constraint(equalTo: habitView.topAnchor, constant: 22),
            nameInputHeader.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),

            nameInputField.topAnchor.constraint(equalTo: nameInputHeader.bottomAnchor, constant: 7),
            nameInputField.leadingAnchor.constraint(equalTo: habitView.leadingAnchor),
            nameInputField.trailingAnchor.constraint(equalTo: habitView.trailingAnchor),

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
            timeSelection.centerYAnchor.constraint(equalTo: timeSelectionSubheader.centerYAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mode = isInEditMode {
            if isInEditMode == true {
                title = "Править"
                deleteHabitButton.isHidden = false

                setupLayout(mode)
                            
                if let habitToEdit = habit { setupEditMode(habitToEdit.customHabit) }
            } else {
                title = "Создать"
                
                setupLayout(mode)
            }
        }
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
}
