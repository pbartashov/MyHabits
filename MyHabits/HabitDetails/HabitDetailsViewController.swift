//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import UIKit

final class HabitDetailsViewController: UIViewController {

    var habit: Habit? {
        didSet {
            title = habit?.name ?? ""
        }
    }

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)

        table.backgroundColor = .myHabitsColor(.lightGray)
        //        table.backgroundColor = .red
        //        table.contentInset = UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
        table.allowsSelection = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.dataSource = self
        table.delegate = self

        return table
    }()

    private let headerView = HabitDetailsTableHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        view.backgroundColor = .myHabitsColor(.mainBackground)

        view.addSubviewsToAutoLayout(tableView)
        tableView.setConstraintsToSafeArea(of: view)

        addObservers()
    }

    deinit {
        removeObservers()
    }

    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never

        let editBarItem = UIBarButtonItem(title: "Править",
                                          style: .plain,
                                          target: self,
                                          action: #selector(editButtonTapped))

        navigationItem.rightBarButtonItem = editBarItem

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
        navigationController?.navigationBar.backgroundColor = .myHabitsColor(.mainBackground)
    }

    @objc
    private func editButtonTapped() {
        let habitViewController = HabitViewController()
        habitViewController.habit = habit
        navigationController?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource methods
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let date = HabitsStore.shared.dates.sorted(by: >)[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.attributedText = createTimeString(from: date)

        if let habit = habit,
           HabitsStore.shared.habit(habit, isTrackedIn: date) {

            cell.tintColor = .myHabitsColor(.purple)
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.contentConfiguration = content

        return cell
    }

    private func createTimeString(from date: Date?) -> NSAttributedString {
        if let date = date {

            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .long
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.doesRelativeDateFormatting = true

            var dateString = dateFormatter.string(from: date)

            if dateString.hasSuffix(" г.") {
                dateString.removeLast(3)
            }

            return NSAttributedString(from: dateString,
                                      font: Fonts.SFProTextRegular17,
                                      lineHeightMultiple: 1.08,
                                      kern: -0.41)
        } else {
            return NSAttributedString()
        }
    }
}

// MARK: -  UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
}

// MARK: - NotificationCenter observers
extension HabitDetailsViewController {
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
    }

    private func removeObservers() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.removeObserver(self,
                                          name: .habitUpdated,
                                          object: HabitsStore.shared)

        notificationCenter.removeObserver(self,
                                          name: .habitRemoved,
                                          object: HabitsStore.shared)
    }

    @objc
    private func onUpdateHabit(_ notification: Notification) {
        if let habitIndex = notification.userInfo?["habitIndex"] as? Int {
            habit = HabitsStore.shared.habits[habitIndex]
        }
    }

    @objc
    private func onRemoveHabit() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
