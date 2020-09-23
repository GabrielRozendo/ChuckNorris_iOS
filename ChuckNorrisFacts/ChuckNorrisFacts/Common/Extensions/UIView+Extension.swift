//
//  UIView+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

extension UIView {
    func addBorder(_ borderColor: CGColor = UIColor.black.cgColor, borderWidth: CGFloat = 1) {
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }

    func addCornerRadius(_ cornerRadius: CGFloat = 5,
                         borderWidth: CGFloat = 1,
                         borderColor: CGColor = UIColor.black.cgColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }

    func addShadow(_ shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOpacity: Float = 1,
                   shadowOffset: CGSize = .zero,
                   shadowRadius: CGFloat = 10) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shouldRasterize = true
    }
}
