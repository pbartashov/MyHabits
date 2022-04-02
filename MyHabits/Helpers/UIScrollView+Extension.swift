//
//  UIScrollView+Extension.swift
//  MyHabits
//
//  Created by Павел Барташов on 27.03.2022.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        let wasScrollEnabled = isScrollEnabled

        isScrollEnabled = false // Иначе скроллится только до contentInset.top

        let point = CGPoint(x: -adjustedContentInset.left,
                            y: -adjustedContentInset.top)

        setContentOffset(point, animated: true)

        if wasScrollEnabled {
            isScrollEnabled = true
        }
    }
}
