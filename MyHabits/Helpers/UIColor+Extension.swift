//
//  UIColor+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 02.04.2022.
//

import UIKit

extension UIColor {
    enum MyHabitsColors: String {
        case blue = "blueColor"
        case green = "greenColor"
        case indigo = "indigoColor"
        case lightGray = "lightGrayColor"
        case mainBackground = "mainBackgroundColor"
        case orange = "orangeColor"
        case purple = "purpleColor"
        case tabBarBackground = "tabBarBackgroundColor"
        case systemGray = "systemGrayColor"
        case systemGray2 = "systemGray2Color"
    }

    static var myHabitsDefaultColor: UIColor {
        myHabitsColor(.orange)
    }

    static func myHabitsColor(_ color: MyHabitsColors) -> UIColor {
        guard let color = UIColor(named: color.rawValue) else {
            fatalError("""
                Failed to load the "\(color.rawValue)" color.
                Make sure the color set is included in the project and the color name is spelled correctly.
            """
            )
        }
        return color
    }
//
//
//
//        UIColor(named: "")
//    }
//
//    static var myHabbitsIndigoColor: UIColor? {
//        UIColor(named: "")
//    }
//
//    static var myHabbitsLightGrayColor: UIColor? {
//        UIColor(named: "")
//    }
//
//    static var myHabbitsMainBackgroundColor: UIColor? {
//        UIColor(named: "")
//    }
//
//    static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }

//    static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }static var myHabbitsPurpleColor: UIColor? {
//        UIColor(named: "purpleColor")
//    }


}
