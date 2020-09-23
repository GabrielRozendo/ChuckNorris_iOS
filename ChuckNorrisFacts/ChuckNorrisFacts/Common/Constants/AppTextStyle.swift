//
//  AppTextStyle.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

enum AppTextStyle {
    // MARK: - CASES

    case title(fontSize: CGFloat = 24)
    case subtitle(fontSize: CGFloat = 18)
    case listItem(fontSize: CGFloat = 14)
    case fact(fontSize: CGFloat = 14)
    case category(fontSize: CGFloat = 16)
    case status(fontSize: CGFloat = 18)

    // MARK: - PRIVATE

    private enum AppFonts: String {
        case pixel04b30 = "04b"
        case courierNew = "Courier New"
    }

    // MARK: - PUBLIC

    var font: UIFont {
        switch self {
        case .title(let fontSize),
             .subtitle(let fontSize):
            return UIFont(name: AppFonts.pixel04b30.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)

        case .fact(let fontSize),
             .listItem(let fontSize):
            return UIFont(name: AppFonts.courierNew.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)

        case .category(let fontSize),
             .status(let fontSize):
            return UIFont(name: AppFonts.courierNew.rawValue, size: fontSize)?.bold()
                ?? UIFont.boldSystemFont(ofSize: fontSize)
        }
    }

    var color: UIColor {
        switch self {
        case .title,
             .subtitle,
             .status: return .flame
        default: return .eerieBlack
        }
    }
}
