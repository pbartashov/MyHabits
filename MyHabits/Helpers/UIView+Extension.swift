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
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func setConstraintsToSafeArea(of view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
