//
//  Fonts.swift
//  MyHabits
//
//  Created by Павел Барташов on 27.03.2022.
//

import UIKit

struct Fonts {
    static var SFProDisplaySemibold20: UIFont {
        createFont(name: "SFProDisplay-Semibold", size: 20)
    }

    static var SFProDisplayBold34: UIFont {
        createFont(name: "SFProDisplay-Bold", size: 34)
    }

    static var SFProTextRegular17: UIFont {
        createFont(name: "SFProText-Regular", size: 17)
    }

    static var SFProTextRegular12: UIFont {
        createFont(name: "SFProText-Regular", size: 12)
    }

    static var SFProTextRegular13: UIFont {
        createFont(name: "SFProText-Regular", size: 13)
    }

    static var SFProTextSemibold13: UIFont {
        createFont(name: "SFProText-Semibold", size: 13)
    }

    static var SFProTextSemibold17: UIFont {
        createFont(name: "SFProText-Semibold", size: 17)
    }

    static func createFont(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            fatalError("""
                Failed to load the "\(name)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
            """
            )
        }
        return font
    }
}
