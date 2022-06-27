//
//  UIButton + Extension.swift
//  Calck
//
//  Created by Konstantin on 26.06.2022.
//

import UIKit

extension UIButton {
    convenience init(text: String, color: UIColor) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .baseButtonColor
        configuration.baseBackgroundColor = color
        
        var selfText = AttributeContainer()
        selfText.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        configuration.attributedTitle = AttributedString(text, attributes: selfText)
        
//        self.init(configuration: configuration, primaryAction: action)
        self.init(configuration: configuration)
        self.layer.cornerRadius = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
