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
        label.font = Fonts.SFProTextSemibold17
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.SFProTextRegular12
        label.textColor = .myHabitsColor(.systemGray2)
        
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        
        label.font = Fonts.SFProTextRegular13
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
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: checkmarkButton.leadingAnchor, constant: -40),

            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 16),
            
            counterLabel.topAnchor.constraint(lessThanOrEqualTo: timeLabel.bottomAnchor, constant: 30),
            counterLabel.topAnchor.constraint(greaterThanOrEqualTo: timeLabel.bottomAnchor, constant: 8),
            counterLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 18),
            
            checkmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalTo: checkmarkButton.heightAnchor),

            contentView.bottomAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20)
        ])
   }
    
    func setup(with habit: Habit) {
        nameLabel.textColor = habit.color
        nameLabel.attributedText = createNameString(from: habit.name)
        
        timeLabel.attributedText = createTimeString(from: habit.dateString)
        
        counterLabel.attributedText = createCounterString(from: "Счётчик: \(habit.trackDates.count)")
        
        checkmarkButton.tintColor = habit.color
        checkmarkButton.isSelected = habit.isAlreadyTakenToday
    }
    
    private func createNameString(from text: String) -> NSAttributedString {
        NSAttributedString(from: text, lineHeightMultiple: 1.08, kern: -0.41)
    }
    
    private func createTimeString(from text: String) -> NSAttributedString {
        NSAttributedString(from: text, lineHeightMultiple: 1.12)
    }
    
    private func createCounterString(from text: String) -> NSAttributedString {
        NSAttributedString(from: text, lineHeightMultiple: 1.16, kern: -0.08)
    }

    @objc
    private func checkmarkButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
}
