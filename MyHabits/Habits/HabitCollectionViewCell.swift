//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Павел Барташов on 06.04.2022.
//

import UIKit

protocol HabitCellDelegate: AnyObject {
    func checkmarkTapped(sender: HabitCollectionViewCell)
}

class HabitCollectionViewCell: UICollectionViewCell {

    weak var delegate: HabitCellDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()

        label.font = Fonts.fontSFProTextSemibold17
//        label.textColor = .myHabitsColor(.blue)

        //        label.setContentHuggingPriority(.init(rawValue: 249), for: .horizontal)
//        label.backgroundColor = .orange

        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()

        label.font = Fonts.fontSFProTextRegular12
        label.textColor = .myHabitsColor(.systemGray2)

        return label
    }()

    private let counterLabel: UILabel = {
        let label = UILabel()

        label.font = Fonts.fontSFProTextRegular13
        label.textColor = .myHabitsColor(.systemGray)

        return label
    }()

    let checkmarkButton: UIButton = {
        let button = UIButton(type: .custom)

        let configuration = UIImage.SymbolConfiguration(pointSize: 36)



        button.setImage(UIImage(systemName: "checkmark.circle.fill",
                                          withConfiguration: configuration),
                                  for: .selected)

        button.setImage(UIImage(systemName: "circle",
                                          withConfiguration: configuration),
                                  for: .normal)

        button.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)

        button.addTarget(self,
                         action: #selector(checkmarkButtonTapped),
                         for: .touchUpInside)

//        button.backgroundColor = .gray
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {

        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemBackground

//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.distribution = .fillProportionally
//        stack.alignment = .center
//        stack.spacing = 8
//
//        stack.addArrangedSubview(createLabel(with: "Всё получится!"))
//        stack.addArrangedSubview(progressLabel)






        setupLayout()



    }

    private func setupLayout() {

        contentView.addSubviewsToAutoLayout(nameLabel,
                                            timeLabel,
                                            counterLabel,
                                            checkmarkButton)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: checkmarkButton.leadingAnchor, constant: -40),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),

            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 16),

            counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30),
            counterLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 18),

            checkmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
//            checkmarkButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -44),

            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalTo: checkmarkButton.heightAnchor),
//            checkmarkButton.widthAnchor.constraint(equalToConstant: 36),
//            checkmarkButton.heightAnchor.constraint(equalToConstant: 36),


            contentView.bottomAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20)

        ])


//        let sizer = UIView()
//        sizer.backgroundColor = .blue
//        contentView.addSubviewsToAutoLayout(sizer)
//        NSLayoutConstraint.activate([
//            sizer.centerYAnchor.constraint(equalTo: checkmarkButton.centerYAnchor, constant: -20),
//            sizer.centerXAnchor.constraint(equalTo: checkmarkButton.centerXAnchor),
//            sizer.heightAnchor.constraint(equalToConstant: 36),
//            sizer.widthAnchor.constraint(equalToConstant: 36)
//        ])
    }


    func setup(with habit: Habit) {
        nameLabel.textColor = habit.color
        nameLabel.attributedText = createNameString(from: habit.name)

        timeLabel.attributedText = createTimeString(from: habit.date)

        counterLabel.attributedText = createCounterString(from: "Счётчик: \(habit.trackDates.count)")

        checkmarkButton.tintColor = habit.color
        checkmarkButton.isSelected = habit.isAlreadyTakenToday
    }

    private func createNameString(from text: String) -> NSAttributedString {
        createAttributedString(from: text, lineHeightMultiple: 1.08, kern: -0.41)
    }

    private func createTimeString(from date: Date) -> NSAttributedString {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return createAttributedString(from: "Каждый день в \(dateFormatter.string(from: date))",
                                      lineHeightMultiple: 1.12, kern: 0.0)
    }

    private func createCounterString(from text: String) -> NSAttributedString {
        createAttributedString(from: text, lineHeightMultiple: 1.16, kern: -0.08)
    }

    private func createAttributedString(from text: String, lineHeightMultiple: CGFloat, kern: NSNumber) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        return NSAttributedString(string: text,
                                  attributes: [NSAttributedString.Key.kern: kern,
                                               NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    @objc
    private func checkmarkButtonTapped() {
        if !checkmarkButton.isSelected {
            delegate?.checkmarkTapped(sender: self)
//            checkmarkButton.isSelected = true
        }

        
    }


}
