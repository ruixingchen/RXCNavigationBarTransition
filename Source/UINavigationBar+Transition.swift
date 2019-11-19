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
        let view = self.rnb_barBackgroundView
        view?.alpha = value
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
        let view = self.rnb_shadowView
        if value {
            view?.alpha = 0
        }else {
            view?.alpha = 1
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

extension UINavigationBar {

    ///按照当前导航栏的样式生成style对象
    internal func rnb_currentStyle()->RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(self.alpha)
        style.backgroundAlphaSetting = .setted(self.rnb_barBackgroundView?.alpha ?? RXCNavigationBarTransition.defaultBackgroundAlpha)
        if let color = self.barTintColor {
            style.barTintColorSetting = .setted(color)
        }else {
            style.barTintColorSetting = .notset
        }
        style.tintColorSetting = .setted(self.tintColor)
        style.titleColorSetting = .setted(self.rnb_titleLabel?.textColor ?? RXCNavigationBarTransition.defaultTitleColor)
        style.shadowViewHiddenSetting = .setted(self.rnb_shadowView?.alpha ?? 1 == 0)
        style.statusBarStyleSetting = .setted(UIApplication.shared.statusBarStyle)
        return style
    }

}
