//
//  UINavigationBar+Transition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {

    internal func rnb_setAlpha(_ value: CGFloat) {
        self.alpha = value
    }

    internal func rnb_setBackgroundAlpha(_ value: CGFloat) {
        self.rnb_barBackgroundView?.alpha = value
    }

    internal func rnb_setBarTintColor(_ value: UIColor?) {
        self.barTintColor = value
    }

    internal func rnb_setTintColor(_ value: UIColor?) {
        self.tintColor = value
    }

    internal func rnb_setTitleColor(_ value: UIColor?) {
        var attributes = self.titleTextAttributes ?? [:]
        attributes[.foregroundColor] = value
        self.titleTextAttributes = attributes
    }

    internal func rnb_setShadowViewHidden(_ value: Bool) {
        if value {
            self.rnb_shadowView?.alpha = 0
        }else {
            self.rnb_shadowView?.alpha = 1
        }
    }

}

extension UINavigationBar {

    internal func applyBarTintColorImmediatelly() {
        let color = self.barTintColor
        self.rnb_barTintColorView?.backgroundColor = color
    }

    internal func applyTintColorImmediatelly() {
        let color = self.tintColor
        self.rnb_stackButtons.forEach({$0.tintColor = color})
    }

    internal func applyTitleColorImmediatelly() {
        if let attributes = self.titleTextAttributes, let att = self.rnb_titleLabel?.attributedText {
            let matt = NSMutableAttributedString(attributedString: att)
            matt.addAttributes(attributes, range: NSRange(location: 0, length: matt.length))
            self.rnb_titleLabel?.attributedText = matt
        }
    }

}
