//
//  UILabel+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

extension UILabel {
    func apply(_ text: String,
               style: AppTextStyle,
               customColor: UIColor? = nil) {
        self.text = text
        self.font = style.font
        self.textColor = customColor ?? style.color
    }
}
