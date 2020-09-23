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
