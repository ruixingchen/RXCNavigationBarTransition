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

    ///返回一个全部是notset的样式
    public static func notset()-> RNBNavigationBarStyle {
        return RNBNavigationBarStyle()
    }

    public static func systemDefault()-> RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(RXCNavigationBarTransition.defaultAlpha)
        style.backgroundAlphaSetting = .setted(RXCNavigationBarTransition.defaultBackgroundAlpha)
        style.backgroundColorSetting = .setted(RXCNavigationBarTransition.defaultBackgroundColor)
        style.foregroundColorSetting = .setted(RXCNavigationBarTransition.defaultForegroundColor)
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
        style.backgroundColorSetting = self.backgroundColorSetting
        style.foregroundColorSetting = self.foregroundColorSetting
        style.tintColorSetting = self.tintColorSetting
        style.titleColorSetting = self.titleColorSetting
        style.shadowViewHiddenSetting = self.shadowViewHiddenSetting
        style.statusBarStyleSetting = self.statusBarStyleSetting
        return self
    }

    public var alphaSetting:RNBSetting<CGFloat> = RNBSetting.notset
    public var backgroundAlphaSetting:RNBSetting<CGFloat> = RNBSetting.notset
    public var backgroundColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var foregroundColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var tintColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var titleColorSetting:RNBSetting<UIColor> = RNBSetting.notset
    public var shadowViewHiddenSetting:RNBSetting<Bool> = RNBSetting.notset
    public var statusBarStyleSetting:RNBSetting<UIStatusBarStyle> = RNBSetting.notset

}
