//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

final class HabitViewController: UIViewController {

    var habit: Habit?

    private lazy var modelView: HabitViewModelProtocol = HabitViewModel(for: self)

    private lazy var tableView: UITableView = {
        let table = UITableView()

        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.allowsSelection = false
        table.contentInset = UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
        table.dataSource = self

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        title = habit == nil ? "Создать" : "Править"

        view.backgroundColor = .myHabitsColor(.mainBackground)
        view.addSubviewsToAutoLayout(tableView)

        setupLayout()

//        habitView.setup(with: Info())
        setupViewModel()




    }

    private func setupViewModel() {
        if let habit = habit {
            modelView.habitName = habit.name
            modelView.habitColor = habit.color
            modelView.habitDate = habit.date
        } else {
            modelView.habitColor = .myHabitsDefaultColor
            modelView.habitDate = .now
        }
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancelButtonTapped))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
//        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .myHabitsColor(.mainBackground)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    

    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }


    @objc
    private func saveButtonTapped() {
        if habit == nil {
            habit = Habit(name: modelView.habitName,
                          date: modelView.habitDate,
                          color: modelView.habitColor)
        } else {
            habit?.name = modelView.habitName
            habit?.date = modelView.habitDate
            habit?.color = modelView.habitColor

        }

        HabitsStore.shared.habits.append(habit!)

        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource methods
extension HabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelView.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return modelView.cells[indexPath.row]
    }


    

//    private func createHeader(with title: String) -> UILabel {
//        let label = UILabel()
//
//        label.font = Fonts.fontSFProTextSemibold13
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.16 // Line height: 18 pt
//
//        label.attributedText = NSMutableAttributedString(string: title,
//                                                         attributes: [NSAttributedString.Key.kern: -0.08,
//                                                                      NSAttributedString.Key.paragraphStyle: paragraphStyle])
//        return label
//    }
}

// MARK: - HabitViewModelDelegate methods
extension HabitViewController: HabitViewModelDelegate {
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker){

        modelView.habitDate = sender.date

    }

    @objc
    func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }

    @objc
    func colorButtonClicked(_ sender: UIButton) {

        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = modelView.habitColor

        present(picker, animated: true, completion: nil)
    }
}

// MARK: - UIColorPickerViewControllerDelegate methods
extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ sender: UIColorPickerViewController) {
        modelView.habitColor = sender.selectedColor
    }
}
