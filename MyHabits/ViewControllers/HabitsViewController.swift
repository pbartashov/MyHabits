//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

final class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true

        let addBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                          style: .plain,
                                          target: self,
                                         action: #selector(plusButtonTapped))
        addBarItem.tintColor = .myHabitsColor(.purple)

        navigationItem.rightBarButtonItem = addBarItem
    }

    @objc
    func plusButtonTapped() {
        let habitViewController = HabitViewController()
        navigationController?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
//        present(habitViewController, animated: true, completion: nil)
    }
}
