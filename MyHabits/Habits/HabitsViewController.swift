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

        return collection
    }()

    private lazy var progressView: ProgressCollectionViewCell = {
        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                        withReuseIdentifier: ProgressCollectionViewCell.identifier,
                                                        for: .init(item: 0, section: 0))
        as! ProgressCollectionViewCell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        view.backgroundColor = .myHabitsColor(.mainBackground)

        view.addSubviewsToAutoLayout(collectionView)
        collectionView.setConstraintsToSafeArea(of: view)

        addObservers()
    }

    deinit {
        removeObservers()
   }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.navigationController?.navigationBar.sizeToFit()
        }, completion: nil)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        title = "Сегодня"

        let addBarItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(plusButtonTapped))

        navigationItem.rightBarButtonItem = addBarItem

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
        navigationController?.navigationBar.backgroundColor = .myHabitsColor(.mainBackground)
    }

    @objc
    private func plusButtonTapped() {
        let habitViewController = HabitViewController()

        present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource methods
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        progressView.setup(with: HabitsStore.shared.todayProgress)
        return progressView
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
}

// MARK: - UICollectionViewDelegate methods
extension HabitsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)

        let habitDetailsViewController = HabitDetailsViewController()
        habitDetailsViewController.habit = HabitsStore.shared.habits[indexPath.item]
        navigationController?.pushViewController(habitDetailsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = collectionView.contentInset.left + collectionView.contentInset.right
        let widthPerItem = view.safeAreaLayoutGuide.layoutFrame.width - paddingSpace

        return CGSize(width: widthPerItem, height: 130)
    }
}

// MARK: - HabitCellDelegate methods
extension HabitsViewController: HabitCellDelegate {
    func checkmarkTapped(sender: HabitCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: sender) {
            let habit = HabitsStore.shared.habits[indexPath.item]

            if habit.isAlreadyTakenToday {
                HabitsStore.shared.unTrack(from: habit, date: .now)
            } else {
                HabitsStore.shared.track(habit)
            }

            progressView.setup(with: HabitsStore.shared.todayProgress)
            sender.setup(with: habit)
        }
    }
}

// MARK: - NotificationCenter observers
extension HabitsViewController {
    private func addObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(self,
                                       selector:#selector(onUpdateHabit(_:)),
                                       name: .habitUpdated,
                                       object: HabitsStore.shared)

        notificationCenter.addObserver(self,
                                       selector:#selector(onRemoveHabit),
                                       name: .habitRemoved,
                                       object: HabitsStore.shared)

        notificationCenter.addObserver(self,
                                       selector: #selector(onOrientationDidChange),
                                       name: UIDevice.orientationDidChangeNotification,
                                       object: nil)
    }

    private func removeObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.removeObserver(self,
                                          name: .habitUpdated,
                                          object: HabitsStore.shared)

        notificationCenter.removeObserver(self,
                                          name: .habitRemoved,
                                          object: HabitsStore.shared)

        notificationCenter.removeObserver(self,
                                          name: UIDevice.orientationDidChangeNotification,
                                          object: nil)
    }
    @objc
    private func onUpdateHabit(_ notification: Notification) {

        if let userInfo = notification.userInfo,
           let habitIndex = userInfo["habitIndex"] as? Int,
           let isNew = userInfo["isNew"] as? Bool {

            let indexPath =  IndexPath(item: habitIndex, section: 0)

            if isNew {
                collectionView.insertItems(at: [indexPath])
            } else {
                collectionView.reloadItems(at: [indexPath])
            }

            progressView.setup(with: HabitsStore.shared.todayProgress)
        }
    }

    @objc
    func onRemoveHabit() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @objc
    func onOrientationDidChange() {
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: self.collectionView.visibleCells.compactMap { self.collectionView.indexPath(for: $0) })
        }
    }
}
