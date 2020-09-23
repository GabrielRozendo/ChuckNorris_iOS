//
//  UIImage+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

// MARK: - HOME

extension UIImage {
    class var share: UIImage {
        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        return UIImage(systemName: "square.and.arrow.up", withConfiguration: largeConfig) ?? UIImage()
    }

    class var link: UIImage {
        let largeConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        return UIImage(systemName: "link", withConfiguration: largeConfig) ?? UIImage()
    }
}

// MARK: - STATUS

extension UIImage {
    class var error: UIImage {
        return UIImage(named: "icons8-error-64") ?? UIImage()
    }

    class var unavailable: UIImage {
        return UIImage(named: "icons8-unavailable") ?? UIImage()
    }

    class var noInternet: UIImage {
        return UIImage(named: "icons8-wi-fi-off-64") ?? UIImage()
    }

    class var loading: UIImage {
        return UIImage(named: "icons8-sand-watch-64") ?? UIImage()
    }

    class var emptyState: UIImage {
        return UIImage(systemName: "doc.text.magnifyingglass") ?? UIImage()
    }
}
