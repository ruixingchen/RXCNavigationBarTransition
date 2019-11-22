//
//  UIColor+Extension.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIColor {

    static func random()->UIColor {
        return UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }

}

extension UIStatusBarStyle: CustomStringConvertible {

    public var description: String {
        switch self {
        case .darkContent:
            return "darkContent"
        case .default:
            return "default"
        case .lightContent:
            return "lightContent"
        @unknown default:
            fatalError()
        }
    }

}
