//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    private let infoTextView: UITextView = {
        let textView = UITextView()

        textView.isEditable = false
        textView.backgroundColor = .white
        textView.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviewsToAutoLayout(infoTextView)

        title = "Информация"

        setupLayout()

        fillTextView()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func fillTextView() {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.lineHeightMultiple = 1.01 // Line height: 24 pt
        titleParagraphStyle.paragraphSpacing = 4

        let fullString = NSMutableAttributedString(string: "\(Info.title)\n",
                                                   attributes: [.kern: 0.38,
                                                                .paragraphStyle: titleParagraphStyle,
                                                                .font: Fonts.fontSFProDisplaySemibold20])

        Info.paragraphs.forEach { text in
            fullString.append(CreateParagraphWith(text: text))
        }

        infoTextView.attributedText = fullString

        infoTextView.scrollToTop(animated: false)
    }

    private func CreateParagraphWith(text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08 // Line height: 22 pt
        paragraphStyle.paragraphSpacingBefore = 12

        return NSAttributedString(string: "\(text)\n",
                                  attributes: [.kern: -0.41,
                                               .paragraphStyle: paragraphStyle,
                                               .font: Fonts.fontSFProTextRegular17])
    }
}
