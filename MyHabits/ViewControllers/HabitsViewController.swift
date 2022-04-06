//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

final class HabitsViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView()

        collection.backgroundColor = .myHabitsColor(.lightGray)
        collection.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        collection.dataSource = self
        collection.register(HabitCollectionViewCell.self,
                                forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)


        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .myHabitsColor(.mainBackground)
//        view.addSubviewsToAutoLayout(tableView)

//        setupLayout()
    }

    func setupNavigationBar() {

        let addBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                          style: .plain,
                                          target: self,
                                         action: #selector(plusButtonTapped))
//        addBarItem.tintColor = .myHabitsColor(.purple)

        navigationItem.rightBarButtonItem = addBarItem

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
        navigationController?.navigationBar.backgroundColor = .myHabitsColor(.mainBackground)

    }

    @objc
    func plusButtonTapped() {
        let habitViewController = HabitViewController()
        navigationController?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
//        present(habitViewController, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource methods
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier,
                                                      for: indexPath)
        as! HabitCollectionViewCell

//        cell.setup(with: photos[indexPath.row])

        return cell
    }


}
