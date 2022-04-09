//
//  HabitViewModel.swift
//  MyHabits
//
//  Created by Павел Барташов on 04.04.2022.
//

import UIKit

protocol HabitViewModelProtocol {
    var habitName: String { get set }
    var habitColor: UIColor { get set }
    var habitDate: Date { get set }
    var cells: [UITableViewCell] { get }

    func setFirstResponder()
}

@objc
protocol HabitViewModelDelegate {
    @objc func colorButtonTapped(_ sender: UIButton)
    @objc func datePickerValueChanged(_ sender: UIDatePicker)
    @objc func returnPressed(_ sender: UITextField)
}

final class HabitViewModel: HabitViewModelProtocol {

    private enum Constants {
        static let padding: CGFloat = 16
        static let interRowDistance: CGFloat = 15
    }

    private(set) var cells = [UITableViewCell]()

    weak var delegate: HabitViewModelDelegate?

    var habitName: String {
        get {
            nameTextField.text ?? ""
        }
        set {
            nameTextField.text = newValue
        }
    }

    var habitColor: UIColor {
        get {
            colorButton.backgroundColor ?? .myHabitsDefaultColor
        }
        set {
            colorButton.backgroundColor = newValue
        }
    }

    var habitDate: Date {
        get {
            timePicker.date
        }
        set {
            timePicker.date = newValue
            updateTimeCell(with: newValue)
        }
    }

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = Fonts.fontSFProTextRegular17
        textField.textColor = .myHabitsColor(.blue)
        //        TODO???
        //        var paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineHeightMultiple = 1.08
        //
        //        // Line height: 22 pt
        //        // (identical to box height)
        //
        //        view.attributedText = NSMutableAttributedString(string: "Бегать по утрам, спать 8 часов и т.п.", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        textField.addTarget(delegate,
                            action: #selector(HabitViewModelDelegate.returnPressed(_:)),
                            for: .editingDidEndOnExit)

        return textField
    }()

    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15

        button.addTarget(delegate,
                         action: #selector(HabitViewModelDelegate.colorButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    private var timeLabel = UILabel()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()

        // Set some of UIDatePicker properties
        picker.timeZone = NSTimeZone.local
        picker.backgroundColor = UIColor.white
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time

        // Add an event to call onDidChangeDate function when value is changed.
        picker.addTarget(delegate,
                         action: #selector(HabitViewModelDelegate.datePickerValueChanged(_:)),
                         for: .valueChanged)

        return picker
    }()


    init (for delegate: HabitViewModelDelegate? = nil) {
        self.delegate = delegate

        cells.append(contentsOf: [createNameCell(),
                                  createColorCell(),
                                  createTimeCell(),
                                  createTimePickerCell()])
       

//        timePicker.date = date
//        updateTimeCell(with: date)
    }

    private func createNameCell() -> UITableViewCell {
        let cell = createCellWith(title: "НАЗВАНИЕ", secondaryView: nameTextField)
        nameTextField.heightAnchor.constraint(equalToConstant: 22).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true

        return cell
    }


    private func createColorCell() -> UITableViewCell {
        let cell = createCellWith(title: "ЦВЕТ", secondaryView: colorButton)
        colorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        colorButton.widthAnchor.constraint(equalToConstant: 30).isActive = true

        return cell
    }

    private func createTimeCell() -> UITableViewCell {
        let cell = createCellWith(title: "ВРЕМЯ", secondaryView: timeLabel)
        timeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true

        return cell
    }

    private func createTimePickerCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.addSubviewsToAutoLayout(timePicker)

        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            timePicker.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 216),

            cell.contentView.bottomAnchor.constraint(equalTo: timePicker.bottomAnchor)
        ])

        return cell

    }

    



    private func createCellWith(title: String, secondaryView: UIView) -> UITableViewCell {
        let cell = UITableViewCell()
        let title = createHeader(with: title)

        cell.contentView.addSubviewsToAutoLayout(title, secondaryView)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: Constants.padding),
            title.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -Constants.padding),
            title.heightAnchor.constraint(equalToConstant: 18),

            secondaryView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 7),
            secondaryView.leadingAnchor.constraint(equalTo: title.leadingAnchor),

            cell.contentView.bottomAnchor.constraint(equalTo: secondaryView.bottomAnchor, constant: Constants.interRowDistance)
        ])

        return cell
    }

    private func createHeader(with title: String) -> UILabel {
        let label = UILabel()

        label.font = Fonts.fontSFProTextSemibold13
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16 // Line height: 18 pt

        label.attributedText = NSAttributedString(string: title,
                                                  attributes: [NSAttributedString.Key.kern: -0.08,
                                                               NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }

    private func updateTimeCell(with date: Date) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08 // Line height: 22 pt

        var attributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.fontSFProTextRegular17,
            .kern: -0.41,
            .paragraphStyle: paragraphStyle
        ]

        let fullString = NSMutableAttributedString(string: "Каждый день в ",
                                                   attributes: attributes)

        attributes.updateValue(UIColor.myHabitsColor(.purple), forKey: .foregroundColor)

        let timeString = NSAttributedString(string: dateFormatter.string(from: date),
                                            attributes: attributes)

        fullString.append(timeString)

        timeLabel.attributedText = fullString
    }

    func setFirstResponder() {
        nameTextField.becomeFirstResponder()
    }
   


}


