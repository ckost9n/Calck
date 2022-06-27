//
//  UIStackView + Extension.swift
//  Calck
//
//  Created by Konstantin on 26.06.2022.
//

import UIKit

extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: views)
        self.backgroundColor = .dispalayColor
        self.spacing = spacing
        self.axis = axis
        self.alignment = .fill
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
