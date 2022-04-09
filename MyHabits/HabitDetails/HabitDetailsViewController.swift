//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import UIKit

class HabitDetailsViewController: UITableViewController {

    weak var habit: Habit?
    weak var habitsStoreDelegate: HabitsStoreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

    }

    private func setupNavigationBar() {

        if let habit = habit {
            title = habit.name
        } else {
            title = "Сегодня"
        }



//       navigationController?.navigationBar.prefersLargeTitles = true
        let editBarItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                          target: self,
                                          action: #selector(editButtonTapped))



        //        addBarItem.tintColor = .myHabitsColor(.purple)

        navigationItem.rightBarButtonItem = editButtonItem

        editButtonItem

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
        navigationController?.navigationBar.backgroundColor = .myHabitsColor(.mainBackground)

    }

    @objc
    func editButtonTapped() {
        let habitViewController = HabitViewController()
        habitViewController.delegate = self
        navigationController?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
    }

}

// MARK: - UITableViewDataSource methods

extension HabitDetailsViewController {
    
}

