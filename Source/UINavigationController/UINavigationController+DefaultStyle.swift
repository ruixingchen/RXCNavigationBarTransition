//
//  UINavigationController+DefaultStyle.swift
//  Example
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationController {

    ///默认样式更改后, 重新设置导航栏样式
    internal func updateNavigationBarStyleAfterDefaultStyleChanged() {
        if let topVC = self.topViewController {
            let style = topVC.rnb_navigationBarStyleForTransition()
            self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false, animatedOnly: nil)
        }
    }

    public internal(set) var rnb_defaultNavigationBarAlphaSetting:RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarDefaultStyle.alphaSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.alphaSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarAlpha(_ value:CGFloat) {
        self.rnb_defaultNavigationBarAlphaSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarAlphaSetting() {
        self.rnb_defaultNavigationBarAlphaSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarBackgroundAlphaSetting:RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarBackgroundAlpha(_ value:CGFloat) {
        self.rnb_defaultNavigationBarBackgroundAlphaSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarBackgroundAlphaSetting() {
        self.rnb_defaultNavigationBarBackgroundAlphaSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarBackgroundColorSetting:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.backgroundColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.backgroundColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarBackgroundColor(_ value:UIColor) {
        self.rnb_defaultNavigationBarBackgroundColorSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarBackgroundColorSetting() {
        self.rnb_defaultNavigationBarBackgroundColorSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarForegroundColorSetting:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.foregroundColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.foregroundColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarForegroundColor(_ value:UIColor) {
        self.rnb_defaultNavigationBarForegroundColorSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarForegroundColorSetting() {
        self.rnb_defaultNavigationBarForegroundColorSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarTintColorSetting:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.tintColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.tintColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarTintColor(_ value:UIColor) {
        self.rnb_defaultNavigationBarTintColorSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarTintColorSetting() {
        self.rnb_defaultNavigationBarTintColorSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarTitleColorSetting:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.titleColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.titleColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarTitleColor(_ value:UIColor) {
        self.rnb_defaultNavigationBarTitleColorSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarTitleColorSetting() {
        self.rnb_defaultNavigationBarTitleColorSetting = .notset
    }

    public internal(set) var rnb_defaultNavigationBarShadowViewHiddenSetting:RNBSetting<Bool> {
        get {
            return self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultNavigationBarShadowViewHidden(_ value:Bool) {
        self.rnb_defaultNavigationBarShadowViewHiddenSetting = .setted(value)
    }
    public func rnb_clearDefaultNavigationBarShadowViewHiddenSetting() {
        self.rnb_defaultNavigationBarShadowViewHiddenSetting = .notset
    }

    public internal(set) var rnb_defaultStatusBarStyleSetting:RNBSetting<UIStatusBarStyle> {
        get {
            return self.rnb_navigationBarDefaultStyle.statusBarStyleSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.statusBarStyleSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }
    public func rnb_setDefaultStatusBarStyle(_ value:UIStatusBarStyle) {
        self.rnb_defaultStatusBarStyleSetting = .setted(value)
    }
    public func rnb_clearDefaultStatusBarStyleSetting() {
        self.rnb_defaultStatusBarStyleSetting = .notset
    }

}
