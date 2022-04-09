//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Павел Барташов on 06.04.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionReusableView {

    private let progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .myHabitsColor(.purple)
        return progress
    }()

//    private lazy var progressLabel: UILabel = {
//        let label = createLabel(with: "0%")
//        label.textAlignment = .right
//        return label
//    }()

    private lazy var progressLabel = createLabel(with: "0%")


    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {

        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .systemBackground

        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 8

        stack.addArrangedSubview(createLabel(with: "Всё получится!"))
        stack.addArrangedSubview(progressLabel)



        

        addSubviewsToAutoLayout(stack, progressBar)

        //        setupLayout()

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.heightAnchor.constraint(equalToConstant: 18),

            progressBar.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 7),

            bottomAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 15)

        ])

    }

    //    private func setupLayout() {
    //
    //        progressBar.setConstraintsToSafeArea(of: self)
    //    }

    private func createLabel(with title: String) -> UILabel {
        let label = UILabel()

        label.textColor = .myHabitsColor(.systemGray2)
        label.font = Fonts.fontSFProTextSemibold13

        label.attributedText = createAttributedString(from: title)
        return label
    }

    private func createAttributedString(from text: String, alignment: NSTextAlignment = .natural) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineHeightMultiple = 1.16 // Line height: 18 pt

        return NSAttributedString(string: text,
                                  attributes: [NSAttributedString.Key.kern: -0.08,
                                               NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }



    func setup(with value: Float) {
        progressLabel.attributedText = createAttributedString(from: "\(Int(value * 100))%",
                                                              alignment: .right)

        progressBar.progress = value
    }
    
}
