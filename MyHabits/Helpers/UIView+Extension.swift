//
//  UIView+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }

    func addSubviewsToAutoLayout(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
