//
//  HabitDetailsViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 21.11.2020.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var habit: HabitWithIndex? {
        didSet {
            guard let habit = habit else { return }
            title = habit.customHabit.name
        }
    }
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
        tv.dataSource = self
        tv.delegate = self
        tv.showsVerticalScrollIndicator = false
        
        return tv
    }()
    private lazy var changeHabitButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem(title: "Править",
                                  style: .done,
                                  target: self,
                                  action: #selector(goToEditingHabits))

        return bbi
    }()
    
    // MARK: - @objc Actions
    @objc func goToEditingHabits() {
        let habitVC = HabitViewController(isInEditMode: true)
        habitVC.habit = habit
        habitVC.habitDetailsVC = self

        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        
        present(habitNC, animated: true, completion: nil)
    }
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubviewWithAutoLayout(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        navigationController?.navigationBar.prefersLargeTitles = false

        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = changeHabitButton
    }
}

// MARK: - Extensions
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as! HabitDetailsTableViewCell
        let date = HabitsStore.shared.dates[indexPath.row]
        
        cell.configure(indexPath.item)

        if HabitsStore.shared.habit(habit!.customHabit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
