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
