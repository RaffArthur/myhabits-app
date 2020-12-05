//
//  HabitsViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {

    // MARK: - Properties
    private lazy var addNewHabit: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "plus")
        bbi.style = .done
        bbi.target = self
        bbi.action = #selector(toAddNewHabitScreen)
        
        return bbi
    }()
    private lazy var removeHabits: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Очистить список"
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(habitsRemoved)

        return bbi
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "silver_light")
        cv.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        cv.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    // MARK: - @objc Actions
    @objc private func toAddNewHabitScreen() {
        let habitVC = UINavigationController(rootViewController: HabitViewController(isInEditMode: false))
        habitVC.modalPresentationStyle = .fullScreen
        present(habitVC, animated: true, completion: nil)
        
        collectionView.reloadData()
    }
    
    @objc private func habitsRemoved() {
        let habitsStore = HabitsStore.shared
        habitsStore.habits.removeAll()
        
        collectionView.reloadData()
    }
    
    @objc private func habitProgressCircleTapped(sender: TapGestureRecognizerWithIndex) {
        let habit = HabitsStore.shared.habits[sender.indexPath!.item]
        
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            
            let cell = collectionView.cellForItem(at: sender.indexPath!) as! HabitCollectionViewCell
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse]) {
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0) {
                    cell.habitProgressCircle.alpha = 1
                }
            } completion: { finished in }
        } else {
            HabitsStore.shared.untrack(habit)
        }
        
        collectionView.reloadData()
    }
    
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubviewWithAutoLayout(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
                        
        view.backgroundColor = .white
                
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Сегодня"
        navigationItem.leftBarButtonItem = removeHabits
        navigationItem.rightBarButtonItem = addNewHabit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
}

// MARK: - Extensions

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let progressCell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            progressCell.configure(HabitsStore.shared)
                        
            return progressCell
        } else {
            let habitsCell: HabitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            habitsCell.habit = HabitsStore.shared.habits[indexPath.item]
            
            let tapGestureRecognizer = TapGestureRecognizerWithIndex(target: self, action: #selector(habitProgressCircleTapped(sender:)))
            tapGestureRecognizer.indexPath = indexPath
            habitsCell.habitProgressCircle.addGestureRecognizer(tapGestureRecognizer)
            
            return habitsCell
        }
    }
}
    
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        } else {
            let habitDetailsVC = HabitDetailsViewController()
            let habit = HabitWithIndex(customHabit: HabitsStore.shared.habits[indexPath.item], habitIndex: indexPath.item)
            habitDetailsVC.habit = habit
            
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 60)
        } else {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 130)
        }
    }
}

