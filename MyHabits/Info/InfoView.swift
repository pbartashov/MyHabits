//
//  InfoView.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

class InfoView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        self.isEditable = false
        self.backgroundColor = .systemBackground
        self.contentInset = UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
   }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with info: Info) {
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.lineHeightMultiple = 1.01 // Line height: 24 pt
        titleParagraphStyle.paragraphSpacing = 4

        let fullString = NSMutableAttributedString(string: "\(info.title)\n",
                                                   attributes: [.kern: 0.38,
                                                                .paragraphStyle: titleParagraphStyle,
                                                                .font: Fonts.SFProDisplaySemibold20])

        info.paragraphs.forEach { text in
            fullString.append(createParagraphWith(text: text))
        }

        self.attributedText = fullString

        self.scrollToTop(animated: false)
    }

    private func createParagraphWith(text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08 // Line height: 22 pt
        paragraphStyle.paragraphSpacingBefore = 12

        return NSAttributedString(string: "\(text)\n",
                                  attributes: [.kern: -0.41,
                                               .paragraphStyle: paragraphStyle,
                                               .font: Fonts.SFProTextRegular17])
    }
}
