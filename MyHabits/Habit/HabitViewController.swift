//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

final class HabitViewController: UIViewController {

    var habit: Habit?
//    weak var delegate: HabitsStoreDelegate?

    private lazy var modelView: HabitViewModelProtocol = HabitViewModel(for: self)

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)

        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.allowsSelection = false
        table.bounces = false
        table.contentInset = UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
        table.dataSource = self
        table.delegate = self
//        table.estimatedRowHeight = 62


        return table
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()

        button.titleLabel?.font = Fonts.SFProTextRegular17
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.myHabitsColor(.red), for: .normal)

        button.backgroundColor = .systemBackground

        button.addTarget(self,
                         action: #selector(deleteButtonTapped),
                         for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        view.backgroundColor = .myHabitsColor(.mainBackground)

        setupLayout()

//        habitView.setup(with: Info())
        setupViewModel()

        if habit == nil {
            title = "Создать"
//            deleteButton.isHidden = true
        } else {
            title = "Править"
        }


//        view.addSubviewsToAutoLayout(tableView)
//        tableView.setConstraintsToSafeArea(of: view)


    }

    override func viewWillAppear(_ animated: Bool) {
        modelView.setFirstResponder()
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

        navigationController?.navigationBar.titleTextAttributes = creatTitleTextAttributes()


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
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill



        stack.addArrangedSubview(tableView)
//        stack.addArrangedSubview(deleteButton)

        let container = UIView()
        container.backgroundColor = .systemBackground
        container.addSubviewsToAutoLayout(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18)
        ])

        
        view.addSubviewsToAutoLayout(container)

        container.setConstraintsToSafeArea(of: view)






//        stack.backgroundColor = .red
//        view.backgroundColor = .green

//        view.addSubviewsToAutoLayout(stack)




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

        HabitsStore.shared.updateStore(with: habit!)
//        delegate?.updateHabit(habit!)

        dismiss(animated: true, completion: nil)
    }

    @objc
    private func deleteButtonTapped() {
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \"\(habit!.name)\"?",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Удалить",
                                       style: .destructive,
                                       handler: { _ in

            HabitsStore.shared.removeFromStore(habit: self.habit!)

            self.dismiss(animated: true, completion: nil)
        })

        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel,
                                         handler: nil)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)



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

// MARK: - UITableViewDelegate methods
extension HabitViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let height = tableView.bounds.height - tableView.contentSize.height

        return height < 0 ? 50 : height
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        deleteButton.backgroundColor = .green
        return deleteButton
    }
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
    func colorButtonTapped(_ sender: UIButton) {

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
