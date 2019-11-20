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
 1，push和通过代码调用pop
    交换push和pop相关的四个函数即可, 在调用真正的push和pop之前保存bar的样式，简单
 2， 滑动手势返回
    监听变化: pop方法被调用, 且coordinator的initiallyInteractive为true, 表示开始进行滑动返回, 之后在updateInteractiveTransition中更新导航栏样式即可
    样式保存: 当pop被调用的时候保存样式即可
 3，点击左上角的返回按钮返回
    系统会自动调用pop, 逻辑和pop保持一致
 */

//MARK: - 存储变量
extension UINavigationController {

    internal struct NavKey {
        static var rnb_navigationEnabled = "rnb_navigationEnabled"
        static var rnb_navigationBarDefaultStyle = "rnb_navigationBarDefaultStyle"
        static var rnb_interactivePopGestureRecognizerTargetAdded = "rnb_interactivePopGestureRecognizerTargetAdded"
        static var updateInteractiveTransitionCoordinator = "updateInteractiveTransitionCoordinator"
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

    internal func rnbnav_setNavigationBarBarTintColor(setting:RNBSetting<UIColor?>) {
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

    internal func rnbnav_setStatusBarStyle() {
        self.setNeedsStatusBarAppearanceUpdate()
    }

    ///状态栏
    @objc open override var preferredStatusBarStyle: UIStatusBarStyle {
        //优先使用topVC的样式
        if let topVC = self.topViewController, let value = topVC.rnb_navigationBarStyleForTransition().statusBarStyleSetting.value {
            return value
        }
        return self.rnb_defaultStatusBarStyle.value ?? RXCNavigationBarTransition.defaultStatusBarStyle
    }

}

//MARK: - 默认样式
extension UINavigationController {

    ///默认样式更改后, 重新设置导航栏样式
    internal func updateNavigationBarStyleAfterDefaultStyleChanged() {
        if let topVC = self.topViewController {
            let style = topVC.rnb_navigationBarStyleForTransition()
            self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false)
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

    public var rnb_defaultNavigationBarBarTintColor:RNBSetting<UIColor?> {
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

extension UINavigationController {

    ///通过样式来更新导航栏
    internal func rnb_applyNavigationBarStyle(style:RNBNavigationBarStyle, applyImmediatelly:Bool) {
        rnblog("开始应用导航栏样式")
        self.rnbnav_setNavigationBarAlpha(setting: style.alphaSetting)
        self.rnbnav_setNavigationBarBackgroundAlpha(setting: style.backgroundAlphaSetting)
        self.rnbnav_setNavigationBarBarTintColor(setting: style.barTintColorSetting)
        self.rnbnav_setNavigationBarTintColor(setting: style.tintColorSetting)
        self.rnbnav_setNavigationBarTitleColor(setting: style.titleColorSetting)
        self.rnbnav_setNavigationBarShadowViewHidden(setting: style.shadowViewHiddenSetting)
        self.rnbnav_setStatusBarStyle()
        if applyImmediatelly {
            rnblog("立刻应用样式")
            self.navigationBar.applyBarTintColorImmediatelly()
            self.navigationBar.applyTintColorImmediatelly()
            self.navigationBar.applyTitleColorImmediatelly()
        }
    }

    ///当没有交互变化的时候调用这个方法来更新导航栏的样式, 只需要关心toVC的样式即可, 无需关心fromVC
    internal func rnb_applyNavigationBarStyleUninteractively(coordinator: UIViewControllerTransitionCoordinator) {
        guard let toController = coordinator.viewController(forKey: .to) else {return}
        rnblog("非交互状态下应用导航栏样式, to: \(String(describing: topViewController))")
        if coordinator.isAnimated {
            coordinator.animate(alongsideTransition: { (_) in
                rnblog("非交互状态下应用导航栏样式动画执行")
                let style = toController.rnb_navigationBarStyleSavedBeforeTransition ?? toController.rnb_navigationBarStyle
                self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: true)
            }) { (_) in
                rnblog("非交互状态动画完毕, 强制应用样式")
                let style = toController.rnb_navigationBarStyleSavedBeforeTransition ?? toController.rnb_navigationBarStyle
                self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false)
            }
        }else {
            rnblog("非交互状态非动画应用导航栏样式")
            let style = toController.rnb_navigationBarStyleSavedBeforeTransition ?? toController.rnb_navigationBarStyle
            self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: true)
        }
    }

    ///在交互状态下更新导航栏样式
    internal func rnb_applyNavigationBarStyleInteractively(fromStyle:RNBNavigationBarStyle, toStyle:RNBNavigationBarStyle, progress:CGFloat) {

        rnblog("交互状态下应用导航栏样式")

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
            var fromColor:UIColor?
            if case let .setted(value) = fromStyle.barTintColorSetting {
                fromColor = value
            }else {
                //没有设置, 取默认颜色
                if case let .setted(navSetted) = self.rnb_defaultNavigationBarBarTintColor {
                    fromColor = navSetted
                }else {
                    fromColor = RXCNavigationBarTransition.defaultBarTintColor
                }
            }
            var toColor:UIColor?
            if case let .setted(value) = toStyle.barTintColorSetting {
                toColor = value
            }else {
                //没有设置, 取默认颜色
                if case let .setted(navSetted) = self.rnb_defaultNavigationBarBarTintColor {
                    toColor = navSetted
                }else {
                    toColor = RXCNavigationBarTransition.defaultBarTintColor
                }
            }
            if fromColor == nil && toColor == nil {
                //至少要有一个设置了颜色, 否则不用计算
                self.rnbnav_setNavigationBarBarTintColor(setting: toStyle.barTintColorSetting)
                self.navigationBar.applyBarTintColorImmediatelly()
            }else {
                //这里需要判断有一个为nil的情况, 让颜色过渡更平滑
                if fromColor == nil && toColor != nil {
                    let toTuple = toColor!.rnb_rgbaTuple()
                    fromColor = UIColor(red: toTuple.r/255, green: toTuple.g/255, blue: toTuple.b/255, alpha: 0.0)
                }else if fromColor != nil && toColor == nil {
                    let fromTuple = fromColor!.rnb_rgbaTuple()
                    toColor = UIColor(red: fromTuple.r/255, green: fromTuple.g/255, blue: fromTuple.b/255, alpha: 0.0)
                }

                //到这里fromColor和toColor都确保有颜色了, 开始计算中间色
                let color = RNBHelper.calculateProgressiveColor(from: fromColor!, to: toColor!, progress: progress)
                self.rnbnav_setNavigationBarBarTintColor(setting: .setted(color))
                self.navigationBar.applyBarTintColorImmediatelly()
            }
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
            ///这里采用渐变来实现
            let fromAlpha:CGFloat = RNBHelper.chooseSettedValue(setting: fromStyle.shadowViewHiddenSetting, setting2: self.rnb_defaultNavigationBarShadowViewHidden, defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden) ? 0 : 1
            let toAlpha:CGFloat = RNBHelper.chooseSettedValue(setting: toStyle.shadowViewHiddenSetting, setting2: self.rnb_defaultNavigationBarShadowViewHidden, defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden) ? 0 : 1
            let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
            self.navigationBar.rnb_shadowView?.alpha = alpha
        }
        if true {
            self.rnbnav_setStatusBarStyle()
        }
    }

}
