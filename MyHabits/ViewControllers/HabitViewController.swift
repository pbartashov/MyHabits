//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

final class HabitViewController: UIViewController {

    private let modelView = HabitViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(cancelButtonTapped))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))

        title = "Создать"

        navigationController?.navigationBar.tintColor = .myHabitsColor(.purple)
        view.backgroundColor = .myHabitsColor(.mainBackground)

        view.addSubviewsToAutoLayout(tableView)

        setupLayout()

//        habitView.setup(with: Info())



        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 21, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
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
