//
//  UINavigationController+Transition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

/*
 动作拦截主要分成几个部分：
 1，push和通过代码调用pop的返回
 交换push和pop函数即可, 在调用super之前保存bar的样式，简单
 2， 滑动手势返回
 监听变化：
 首先会调用navigationBar delegate 中的shouldPop方法，这里如果coordinator的initiallyInteractive为true，表示是手势滑动返回， 我们需要监听手势交互状态的变化，手指如果在中途离开屏幕，会调用变化closure，将剩余的动画完成
 如果本次手势交互状态没有变化，则所有的动画都在 _updateInteractiveTransition，当用户滑动的时候，会持续调用这个函数
 样式保存：当本界面第一次push的时候，为滑动返回手势添加target，点击的时候直接保存样式
 3，点击左上角的返回按钮返回
 监听变化：当shoudPop被调用，且coordinator的initiallyInteractive为false，表示点击了返回按钮
 样式保存：在返回之前保存样式即可

 样式保存:
 1, push和pop方法直接调用:
    在交换后的方法里面提前调用保存方法
 2, 滑动手势返回:
    给滑动手势添加一个target, target接收到消息的时候保存
 3, 点击左上角返回按钮
    在navigationBarDelegate接收到shouldPop的时候保存

 */

//MARK: - 存储变量
extension UINavigationController {

    internal struct NavKey {
        static var rnb_navigationEnabled = "rnb_navigationEnabled"
        static var rnb_navigationBarDefaultStyle = "rnb_navigationBarDefaultStyle"
        static var rnb_interactivePopGestureRecognizerTargetAdded = "rnb_interactivePopGestureRecognizerTargetAdded"
    }

    public var rnb_navigationEnabled:RNBSetting<Bool> {
        get {
            if let value = objc_getAssociatedObject(self, &NavKey.rnb_navigationEnabled) as? RNBSetting<Bool> {
                return value
            }else {
                return RNBSetting.notset
            }
        }
        set {
            objc_setAssociatedObject(self, &NavKey.rnb_navigationEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///可以给navigationController设置一个默认的样式, 让不同的导航栏有不同的默认样式
    internal var rnb_navigationBarDefaultStyle: RNBNavigationBarStyle {
        get {
            var style = objc_getAssociatedObject(self, &NavKey.rnb_navigationBarDefaultStyle) as? RNBNavigationBarStyle
            if style == nil {
                style = RNBNavigationBarStyle()
                self.rnb_navigationBarDefaultStyle = style!
            }
            return style!
        }
        set {
            objc_setAssociatedObject(self, &NavKey.rnb_navigationBarDefaultStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

//MARK: - 设置样式
extension UINavigationController {

    internal func rnbnav_setNavigationBarAlpha(setting:RNBSetting<CGFloat>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.alphaSetting, defaultValue: RXCNavigationBarTransition.defaultAlpha)
        self.navigationBar.rnb_setAlpha(value)
    }

    internal func rnbnav_setNavigationBarBackgroundAlpha(setting:RNBSetting<CGFloat>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting, defaultValue: RXCNavigationBarTransition.defaultBackgroundAlpha)
        self.navigationBar.rnb_setBackgroundAlpha(value)
    }

    internal func rnbnav_setNavigationBarBarTintColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.barTintColorSetting, defaultValue: RXCNavigationBarTransition.defaultBarTintColor)
        self.navigationBar.rnb_setBarTintColor(value)
    }

    internal func rnbnav_setNavigationBarTintColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.tintColorSetting, defaultValue: RXCNavigationBarTransition.defaultTintColor)
        self.navigationBar.rnb_setTintColor(value)
    }

    internal func rnbnav_setNavigationBarTitleColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.titleColorSetting, defaultValue: RXCNavigationBarTransition.defaultTitleColor)
        self.navigationBar.rnb_setTitleColor(value)
    }

    internal func rnbnav_setNavigationBarShadowViewHidden(setting:RNBSetting<Bool>) {
        let value = RNBHelper.chooseSettedValue(setting: setting, setting2: self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting, defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden)
        self.navigationBar.rnb_setShadowViewHidden(value)
    }

}

//MARK: - 默认样式
extension UINavigationController {

    ///默认样式更改后, 重新设置导航栏样式
    internal func updateNavigationBarStyleAfterDefaultStyleChanged() {
        if let topVC = self.topViewController {
            let style = topVC.rnb_navigationBarStyleForTransition()
            self.rnb_updateNavigationBarStyle(style: style, applyImmediatelly: false)
        }
    }

    public var rnb_defaultNavigationBarAlpha:RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarDefaultStyle.alphaSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.alphaSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultNavigationBarBackgroundAlpha:RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultNavigationBarBarTintColor:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.barTintColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.barTintColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultNavigationBarTintColor:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.tintColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.tintColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultNavigationBarTitleColor:RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarDefaultStyle.titleColorSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.titleColorSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultNavigationBarShadowViewHidden:RNBSetting<Bool> {
        get {
            return self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

    public var rnb_defaultStatusBarStyle:RNBSetting<UIStatusBarStyle> {
        get {
            return self.rnb_navigationBarDefaultStyle.statusBarStyleSetting
        }
        set {
            self.rnb_navigationBarDefaultStyle.statusBarStyleSetting = newValue
            self.updateNavigationBarStyleAfterDefaultStyleChanged()
        }
    }

}
//MARK: - 更新导航栏
extension UINavigationController {

    ///通过样式来更新导航栏
    internal func rnb_updateNavigationBarStyle(style:RNBNavigationBarStyle, applyImmediatelly:Bool) {
        self.rnbnav_setNavigationBarAlpha(setting: style.alphaSetting)
        self.rnbnav_setNavigationBarBackgroundAlpha(setting: style.backgroundAlphaSetting)
        self.rnbnav_setNavigationBarBarTintColor(setting: style.barTintColorSetting)
        self.rnbnav_setNavigationBarTintColor(setting: style.tintColorSetting)
        self.rnbnav_setNavigationBarTitleColor(setting: style.titleColorSetting)
        self.rnbnav_setNavigationBarShadowViewHidden(setting: style.shadowViewHiddenSetting)
        self.setNeedsStatusBarAppearanceUpdate()
        if applyImmediatelly {
            self.navigationBar.applyBarTintColorImmediatelly()
            self.navigationBar.applyTintColorImmediatelly()
            self.navigationBar.applyTitleColorImmediatelly()
        }
    }

    ///当没有交互变化的时候调用这个方法来更新导航栏的样式, 只需要关心toVC的样式即可, 无需关心fromVC
    internal func rnb_updateNavigationBarAppearenceUninteractive(coordinator: UIViewControllerTransitionCoordinator) {
        guard let toController = coordinator.viewController(forKey: .to) else {return}
        if coordinator.isAnimated {
            coordinator.animate(alongsideTransition: { (_) in
                let style = toController.rnb_navigationBarStyleSavedBeforeTransition ?? toController.rnb_navigationBarStyle
                self.rnb_updateNavigationBarStyle(style: style, applyImmediatelly: true)
            }, completion: nil)
        }else {
            let style = toController.rnb_navigationBarStyleSavedBeforeTransition ?? toController.rnb_navigationBarStyle
            self.rnb_updateNavigationBarStyle(style: style, applyImmediatelly: true)
        }
    }

    ///在交互状态下更新导航栏样式
    internal func rnb_updateNavigationBarStyleOnInteractive(fromStyle:RNBNavigationBarStyle, toStyle:RNBNavigationBarStyle, progress:CGFloat) {
        if true {
            if let fromAlpha = fromStyle.alphaSetting.value {
                let toAlpha = RNBHelper.chooseSettedValue(setting: toStyle.alphaSetting, setting2: self.rnb_navigationBarDefaultStyle.alphaSetting, defaultValue: RXCNavigationBarTransition.defaultAlpha)
                let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
                self.rnbnav_setNavigationBarAlpha(setting: .setted(alpha))
            }else {
                self.rnbnav_setNavigationBarAlpha(setting: toStyle.alphaSetting)
            }
        }
        if true {
            if let fromAlpha = fromStyle.backgroundAlphaSetting.value {
                let toAlpha = RNBHelper.chooseSettedValue(setting: toStyle.backgroundAlphaSetting, setting2: self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting, defaultValue: RXCNavigationBarTransition.defaultBackgroundAlpha)
                let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
                self.rnbnav_setNavigationBarBackgroundAlpha(setting: .setted(alpha))
            }else {
                self.rnbnav_setNavigationBarBackgroundAlpha(setting: toStyle.backgroundAlphaSetting)
            }
        }
        if true {
            if let fromColor = fromStyle.barTintColorSetting.value {
                let toColor = RNBHelper.chooseSettedValue(setting: toStyle.barTintColorSetting, setting2: self.rnb_navigationBarDefaultStyle.barTintColorSetting, defaultValue: RXCNavigationBarTransition.defaultBarTintColor)
                let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
                self.rnbnav_setNavigationBarBarTintColor(setting: .setted(color))
            }else {
                self.rnbnav_setNavigationBarBarTintColor(setting: toStyle.barTintColorSetting)
            }
            self.navigationBar.applyBarTintColorImmediatelly()
        }
        if true {
            if let fromColor = fromStyle.tintColorSetting.value {
                let toColor = RNBHelper.chooseSettedValue(setting: toStyle.tintColorSetting, setting2: self.rnb_navigationBarDefaultStyle.tintColorSetting, defaultValue: RXCNavigationBarTransition.defaultTintColor)
                let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
                self.rnbnav_setNavigationBarTintColor(setting: .setted(color))
            }else {
                self.rnbnav_setNavigationBarTintColor(setting: toStyle.tintColorSetting)
            }
            self.navigationBar.applyTintColorImmediatelly()
        }
        if true {
            if let fromColor = fromStyle.titleColorSetting.value {
                let toColor = RNBHelper.chooseSettedValue(setting: toStyle.titleColorSetting, setting2: self.rnb_navigationBarDefaultStyle.titleColorSetting, defaultValue: RXCNavigationBarTransition.defaultTitleColor)
                let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
                self.rnbnav_setNavigationBarTitleColor(setting: .setted(color))
            }else {
                self.rnbnav_setNavigationBarTitleColor(setting: toStyle.titleColorSetting)
            }
            self.navigationBar.applyTitleColorImmediatelly()
        }
        if true {
            self.rnbnav_setNavigationBarShadowViewHidden(setting: toStyle.shadowViewHiddenSetting)
        }

    }

}
