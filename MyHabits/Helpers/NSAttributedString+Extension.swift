//
//  NSAttributedString+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 09.04.2022.
//

import UIKit

extension NSAttributedString {
    convenience public init(from text: String, lineHeightMultiple: CGFloat, kern: NSNumber = 0.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        self.init(string: text,
                  attributes: [NSAttributedString.Key.kern: kern,
                               NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    convenience public init(from text: String, font: UIFont, lineHeightMultiple: CGFloat, kern: NSNumber = 0.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        self.init(string: text,
                  attributes: [NSAttributedString.Key.font: font,
                               NSAttributedString.Key.kern: kern,
                               NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
