//
//  UIColor+RNBExtension.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/20/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIColor {

    public func rnb_rgbaTuple()->(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }

}
