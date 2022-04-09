//
//  HabitDetailsTableHeader.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import UIKit

class HabitDetailsTableHeaderView: UIView {

    private let titleView: UILabel = {
        let label = UILabel()

        label.font = Fonts.SFProTextRegular13
        label.textColor = .myHabitsColor(.tableSectionHeaderTex)
        label.attributedText = NSAttributedString(from: "АКТИВНОСТЬ", lineHeightMultiple: 1.16, kern: -0.08)
        label.backgroundColor = .myHabitsColor(.lightGray)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        addSubviewsToAutoLayout(titleView)

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 7)
        ])
    }
}
