//
//  HabitView.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

class HabitView: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = Fonts.fontSFProTextRegular17
//        TODO???
//        var paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.08
//
//        // Line height: 22 pt
//        // (identical to box height)
//
//        view.attributedText = NSMutableAttributedString(string: "Бегать по утрам, спать 8 часов и т.п.", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let colorView = UIButton()
//        colorView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        colorView.backgroundColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1)
        colorView.layer.cornerRadius = 15
//        colorView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        colorView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        colorView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        colorView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        let timePicker = UIDatePicker()

       // Set some of UIDatePicker properties
        timePicker.timeZone = NSTimeZone.local
        timePicker.backgroundColor = UIColor.white

        // Add an event to call onDidChangeDate function when value is changed.
        timePicker.addTarget(self, action: #selector(HabitView.datePickerValueChanged(_:)), for: .valueChanged)


//let a = textField.contentHuggingPriority(for: .vertical)
//        let c = colorView.contentHuggingPriority(for: .vertical)

//        [createHeader(with: "НАЗВАНИЕ"),
//         textField,
//         createHeader(with: "ЦВЕТ"),
//         colorView,
//         createHeader(with: "ВРЕМЯ"), UIView()
////         timePicker
//        ].forEach {
//            addArrangedSubview($0)
//        }

//        let b =  colorView.widthAnchor.constraint(equalToConstant: 30)
//            b.priority = .init(rawValue: 1000)
//
//        NSLayoutConstraint.activate([
//           b
//           ])

    }


    private func createHeader(with title: String) -> UILabel {
        let label = UILabel()
        
        label.font = Fonts.fontSFProTextSemibold13
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16 // Line height: 18 pt

        label.attributedText = NSMutableAttributedString(string: title,
                                                         attributes: [NSAttributedString.Key.kern: -0.08,
                                                                      NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }

    @objc
    func datePickerValueChanged(_ sender: UIDatePicker){

        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()

        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"

        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)

        print("Selected value \(selectedDate)")
    }



}
