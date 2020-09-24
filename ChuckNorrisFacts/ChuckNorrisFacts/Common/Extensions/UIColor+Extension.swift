//
//  UIColor+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: - APP COLORS

extension UIColor {
    static var flame: UIColor {
        return UIColor(named: "Flame") ?? UIColor(displayP3Red: 0.945, green: 0.357, blue: 0.137, alpha: 100)
    }

    static var eerieBlack: UIColor {
        return UIColor(named: "EerieBlack") ?? UIColor(displayP3Red: 0.133, green: 0.133, blue: 0.133, alpha: 100)
    }

    static var blueNCS: UIColor {
        return UIColor(named: "BlueNCS") ?? UIColor(displayP3Red: 0.133, green: 0.553, blue: 0.733, alpha: 100)
    }

    static var coyoteBrown: UIColor {
        return UIColor(named: "CoyoteBrown") ?? UIColor(displayP3Red: 0.549, green: 0.384, blue: 0.224, alpha: 100)
    }
}

// MARK: - UICOLOR UTILS

extension UIColor {
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: abs(percentage))
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: -1 * abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }

        return self
    }
}
