//
//  UINavigationBar+Style.swift
//  Example
//
//  Created by ruixingchen on 11/24/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {

    internal func rnb_setAlpha(_ value: CGFloat) {
        self.alpha = value
    }

    internal func rnb_setBackgroundAlpha(_ value: CGFloat) {
        self.rnb_backgroundAlphaSetted = value
        guard let view = self.rnb_barBackgroundView else {return}
        view.alpha = value
    }

    internal func rnb_setBackgroundColor(_ value: UIColor) {
        self.rnb_rearrangeSubviews()
        self.rnb_backgroundView.backgroundColor = value
    }

    internal func rnb_setForegroundColor(_ value: UIColor) {
        self.rnb_rearrangeSubviews()
        self.rnb_foregroundView.backgroundColor = value
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
        //我们希望能够以渐变的形式来显示和隐藏底部的阴影view
        self.rnb_shadowView1.alpha = value ? 0 : 1
    }

}

extension UINavigationBar {

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

    internal func applyShadowHiddenImmediately() {
        //nothing
    }

}

//MARK: - 样式
extension UINavigationBar {

    ///按照当前导航栏的样式生成style对象
    internal func rnb_currentStyle()->RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(self.alpha)
        style.backgroundAlphaSetting = .setted(self.rnb_barBackgroundView?.alpha ?? RXCNavigationBarTransition.defaultBackgroundAlpha)
        style.backgroundColorSetting = .setted(self.rnb_backgroundView.backgroundColor ?? UIColor.clear)
        style.foregroundColorSetting = .setted(self.rnb_foregroundView.backgroundColor ?? UIColor.clear)
        style.tintColorSetting = .setted(self.tintColor)
        style.titleColorSetting = .setted(self.rnb_titleLabel?.textColor ?? RXCNavigationBarTransition.defaultTitleColor)
        style.shadowViewHiddenSetting = .setted(self.rnb_shadowView1.alpha == 0)
        if #available(iOS 13, *) {
            style.statusBarStyleSetting = .setted(self.window?.windowScene?.statusBarManager?.statusBarStyle ?? .default)
        }else {
            style.statusBarStyleSetting = .setted(UIApplication.shared.statusBarStyle)
        }
        return style
    }

}
