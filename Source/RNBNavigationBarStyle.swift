//
//  RNBNavigationBarStyle.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public final class RNBNavigationBarStyle {

    public init() {
        
    }

    public static func notsetted()-> RNBNavigationBarStyle {
        return RNBNavigationBarStyle()
    }

    public static func systemDefault()-> RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(RXCNavigationBarTransition.defaultAlpha)
        style.backgroundAlphaSetting = .setted(RXCNavigationBarTransition.defaultBackgroundAlpha)
        style.barTintColorSetting = .setted(RXCNavigationBarTransition.defaultBarTintColor)
        style.tintColorSetting = .setted(RXCNavigationBarTransition.defaultTintColor)
        style.titleColorSetting = .setted(RXCNavigationBarTransition.defaultTitleColor)
        style.shadowViewHiddenSetting = .setted(RXCNavigationBarTransition.defaultShadowViewHidden)
        style.statusBarStyleSetting = .setted(RXCNavigationBarTransition.defaultStatusBarStyle)
        return style
    }

    public func copy()->Self {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = self.alphaSetting
        style.backgroundAlphaSetting = self.backgroundAlphaSetting
        style.barTintColorSetting = self.barTintColorSetting
        style.tintColorSetting = self.tintColorSetting
        style.titleColorSetting = self.titleColorSetting
        style.shadowViewHiddenSetting = self.shadowViewHiddenSetting
        style.statusBarStyleSetting = self.statusBarStyleSetting
        return self
    }

    public var alphaSetting:RNBSetting<CGFloat> = RNBSetting.notset
    public var backgroundAlphaSetting:RNBSetting<CGFloat> = RNBSetting.notset
    public var barTintColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var tintColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var titleColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var shadowViewHiddenSetting:RNBSetting<Bool> = RNBSetting.notset
    public var statusBarStyleSetting:RNBSetting<UIStatusBarStyle> = RNBSetting.notset

    /*
    internal var alpha:CGFloat {
        get {
            return self.alphaSetting.value ?? RXCNavigationBarTransition.defaultAlpha
        }
        set {self.alphaSetting = RNBSetting.setted(newValue)}
    }

    internal var backgroundAlpha:CGFloat {
        get {return self.backgroundAlphaSetting.value ?? RXCNavigationBarTransition.defaultBackgroundAlpha}
        set {self.backgroundAlphaSetting = RNBSetting.setted(newValue)}
    }

    internal var barTintColor:UIColor {
        get {return self.barTintColorSetting.value ?? RXCNavigationBarTransition.defaultBarTintColor}
        set {self.barTintColorSetting = RNBSetting.setted(newValue)}
    }

    public var tintColor:UIColor {
        get {return self.tintColorSetting.value ?? RXCNavigationBarTransition.defaultTintColor}
        set {self.tintColorSetting = RNBSetting.setted(newValue)}
    }

    internal var titleColor:UIColor {
        get {return self.titleColorSetting.value ?? RXCNavigationBarTransition.defaultTitleColor}
        set {self.titleColorSetting = RNBSetting.setted(newValue)}
    }

    internal var shadowViewHidden:Bool {
        get {return self.shadowViewHiddenSetting.value ?? RXCNavigationBarTransition.defaultShadowViewHidden}
        set {self.shadowViewHiddenSetting = RNBSetting.setted(newValue)}
    }

    internal var statusBarStyle:UIStatusBarStyle {
        get {return self.statusBarStyleSetting.value ?? RXCNavigationBarTransition.defaultStatusBarStyle}
        set {self.statusBarStyleSetting = RNBSetting.setted(newValue)}
    }
     */

}
