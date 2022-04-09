//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

final class HabitsViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 12
        collectionViewLayout.headerReferenceSize = CGSize(width: 0, height: 60)


        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout)

        collection.backgroundColor = .myHabitsColor(.lightGray)
        collection.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
        collection.dataSource = self
        collection.delegate = self

        collection.register(ProgressCollectionViewCell.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: ProgressCollectionViewCell.identifier)

        collection.register(HabitCollectionViewCell.self,
                            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)

//        collection.backgroundColor = .green
        return collection
    }()

    private lazy var progressView: ProgressCollectionViewCell = {
        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                        withReuseIdentifier: ProgressCollectionViewCell.identifier,
                                                        for: .init(item: 0, section: 0))
        as! ProgressCollectionViewCell
//            headerView.setup(with: 0.4)
//            return headerView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        title = "Сегодня"
        
        view.backgroundColor = .myHabitsColor(.mainBackground)
//        view.addSubviewsToAutoLayout(tableView)

//        setupLayout()
        view.addSubviewsToAutoLayout(collectionView)

        collectionView.setConstraintsToSafeArea(of: view)
    }

    private func setupNavigationBar() {

        navigationController?.navigationBar.prefersLargeTitles = true

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
        habitViewController.delegate = self
        navigationController?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
//        present(habitViewController, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource methods
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            progressView.setup(with: HabitsStore.shared.todayProgress)
            return progressView
        }

        fatalError()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier,
                                                      for: indexPath)
        as! HabitCollectionViewCell

        cell.delegate = self
        cell.setup(with: HabitsStore.shared.habits[indexPath.item])

        return cell
    }




//    let invalidationContext = UICollectionViewLayoutInvalidationContext()
//    invalidationContext.invalidateSupplementaryElements(ofKind: "", at: [])
//    collectionView.collectionViewLayout.invalidateLayout(with: invalidationContext)



}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension HabitsViewController: UICollectionViewDelegateFlowLayout {

//    private var itemsPerRow: CGFloat { 3 }
//    private var spacing: CGFloat { 0 }
//    private enum Constants {
//        static let insetForSection = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = collectionView.contentInset.left + collectionView.contentInset.right
//        let availableWidth = view.safeAreaLayoutGuide.layoutFrame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow

        let widthPerItem = view.safeAreaLayoutGuide.layoutFrame.width - paddingSpace







        return CGSize(width: widthPerItem, height: 130)
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int
//    ) -> UIEdgeInsets {
//        UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
//    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        12
//    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int)
//    -> CGFloat {
//        spacing
//    }
}

// MARK: - HabitCellDelegate methods
extension HabitsViewController: HabitCellDelegate {
    func checkmarkTapped(sender: HabitCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: sender) {
            let habit = HabitsStore.shared.habits[indexPath.item]
            if !habit.isAlreadyTakenToday {
                HabitsStore.shared.track(habit)
                progressView.setup(with: HabitsStore.shared.todayProgress)
                sender.setup(with: habit)
            }
        }
    }
}

// MARK: - HabitsStoreDelegate methods
extension HabitsViewController: HabitsStoreDelegate {
    func updateHabit(_ habit: Habit) {

        var habits = HabitsStore.shared.habits

        if let habitIndex = habits.firstIndex(of: habit) {
            habits[habitIndex] = habit

            let indexPath = IndexPath(item: habitIndex, section: 0)
            collectionView.reloadItems(at: [indexPath])
        } else {
            HabitsStore.shared.habits.append(habit)

            let indexPath =  IndexPath(item: habits.count, section: 0)
            collectionView.insertItems(at: [indexPath])
        }




    }

    func removeHabit(_ sender: Habit) {
        
    }


}
