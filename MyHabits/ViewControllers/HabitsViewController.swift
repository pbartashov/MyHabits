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
        addBarItem.tintColor = UIColor(named: "purpleColor")

        navigationItem.rightBarButtonItem = addBarItem
    }

    @objc
    func plusButtonTapped() {
//        let infoViewController = InfoViewController()
//        present(infoViewController, animated: true, completion: nil)
    }
}
