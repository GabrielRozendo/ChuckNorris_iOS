//
//  String+Extension.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

extension String {
    private var isBig: Bool { return count >= 80 }
    var factFontSize: CGFloat { return isBig ? 16 : 24 }
}
