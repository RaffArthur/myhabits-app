//
//  HabitsViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var addHabit: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "plus")
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(addNewHabbit)
        
        return bbi
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        cv.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        cv.backgroundColor = UIColor(named: "silver_light")
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    // MARK: - @objc Actions
    @objc func addNewHabbit() {
        let habitVC = UINavigationController(rootViewController: HabitViewController())
        present(habitVC, animated: true, completion: nil)
    }
    
    // MARK: - View Funcs
    func setupLayout() {
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
        navigationItem.rightBarButtonItem = addHabit
    }
}

// MARK: - Extensions
extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let store = HabitsStore.shared.habits
            return store.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let progressCell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            
            return progressCell

        } else {
            let habitsCell: HabitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            
            return habitsCell
        }
    }
}
    
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else {
            return UIEdgeInsets(top: 18, left: 16, bottom: 12, right: 16)
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
