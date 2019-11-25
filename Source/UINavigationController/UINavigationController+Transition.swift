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

    ///如果设置有值, 则直接按照设置的值处理enabled, 如果为nil, 则进入workingMode处理
    public var rnb_navigationEnabled:Bool? {
        get {
            return objc_getAssociatedObject(self, &NavKey.rnb_navigationEnabled) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &NavKey.rnb_navigationEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///给navigationController设置一个默认的样式, 让不同的导航栏有不同的默认样式
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

    ///检查style的值, 将所有的的notset转换为setted(其值为本地设置的默认值)
    @discardableResult
    internal func validateNavigationBarStyle(style:RNBNavigationBarStyle)->RNBNavigationBarStyle {
        if !style.alphaSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultAlpha, settings: self.rnb_navigationBarDefaultStyle.alphaSetting)
            style.alphaSetting = .setted(value)
        }
        if !style.backgroundAlphaSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundAlpha, settings: self.rnb_defaultNavigationBarBackgroundAlphaSetting)
            style.backgroundAlphaSetting = .setted(value)
        }
        if !style.backgroundColorSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundColor, settings: self.rnb_defaultNavigationBarBackgroundColorSetting)
            style.backgroundColorSetting = .setted(value)
        }
        if !style.foregroundColorSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultForegroundColor, settings: self.rnb_defaultNavigationBarForegroundColorSetting)
            style.foregroundColorSetting = .setted(value)
        }
        if !style.tintColorSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTintColor, settings: self.rnb_defaultNavigationBarTintColorSetting)
            style.tintColorSetting = .setted(value)
        }
        if !style.titleColorSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTitleColor, settings: self.rnb_defaultNavigationBarTitleColorSetting)
            style.titleColorSetting = .setted(value)
        }
        if !style.shadowViewHiddenSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden, settings: self.rnb_defaultNavigationBarShadowViewHiddenSetting)
            style.shadowViewHiddenSetting = .setted(value)
        }
        if !style.statusBarStyleSetting.setted {
            let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultStatusBarStyle, settings: self.rnb_defaultStatusBarStyleSetting)
            style.statusBarStyleSetting = .setted(value)
        }
        return style
    }

}

//MARK: - 设置样式
extension UINavigationController {

    internal func rnbnav_setNavigationBarAlpha(setting:RNBSetting<CGFloat>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultAlpha, settings: setting, self.rnb_navigationBarDefaultStyle.alphaSetting)
        self.navigationBar.rnb_setAlpha(value)
    }

    internal func rnbnav_setNavigationBarBackgroundAlpha(setting:RNBSetting<CGFloat>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundAlpha, settings: setting, self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting)
        self.navigationBar.rnb_setBackgroundAlpha(value)
    }

    internal func rnbnav_setNavigationBarBackgroundColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundColor, settings: setting, self.rnb_navigationBarDefaultStyle.backgroundColorSetting)
        self.navigationBar.rnb_setBackgroundColor(value)
    }

    internal func rnbnav_setNavigationBarForegroundColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultForegroundColor, settings: setting, self.rnb_navigationBarDefaultStyle.foregroundColorSetting)
        self.navigationBar.rnb_setForegroundColor(value)
    }

    internal func rnbnav_setNavigationBarTintColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTintColor, settings: setting, self.rnb_navigationBarDefaultStyle.tintColorSetting)
        self.navigationBar.rnb_setTintColor(value)
    }

    internal func rnbnav_setNavigationBarTitleColor(setting:RNBSetting<UIColor>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTitleColor, settings: setting, self.rnb_navigationBarDefaultStyle.titleColorSetting)
        self.navigationBar.rnb_setTitleColor(value)
    }

    internal func rnbnav_setNavigationBarShadowViewHidden(setting:RNBSetting<Bool>) {
        let value = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden, settings: setting, self.rnb_navigationBarDefaultStyle.shadowViewHiddenSetting)
        self.navigationBar.rnb_setShadowViewHidden(value)
    }

    internal func rnbnav_setStatusBarStyle() {
        self.setNeedsStatusBarAppearanceUpdate()
    }

    ///状态栏
    @objc open override var preferredStatusBarStyle: UIStatusBarStyle {
        //优先使用topVC的样式
        if let topVC = self.topViewController {
            if let value = topVC.rnb_navigationBarStyleForTransition().statusBarStyleSetting.value {
                return value
            }else {
                //topVC没有设置样式, 需要判断topVC是否显示了, 如果topVC已经显示过了, 且仍然没有设置style, 则采用默认设置, 如果topVC没有调用viewDidLoad, 说明topVC尚未进入显示流程, 我们保持样式不变
                if topVC.rnb_viewDidLoad_called {
                    //topVC主动不设置
                    let style = self.rnb_defaultStatusBarStyleSetting.value ?? RXCNavigationBarTransition.defaultStatusBarStyle
                    return style
                }else {
                    //topVC尚未进入显示流程, 保持不变
                    if #available(iOS 13, *) {
                        return self.view.window?.windowScene?.statusBarManager?.statusBarStyle ?? self.rnb_defaultStatusBarStyleSetting.value ?? RXCNavigationBarTransition.defaultStatusBarStyle
                    }else {
                        return UIApplication.shared.statusBarStyle
                    }
                }
            }
        }else {
            //没有topVC
            let style = self.rnb_defaultStatusBarStyleSetting.value ?? RXCNavigationBarTransition.defaultStatusBarStyle
            return style
        }
    }

}



extension UINavigationController {

    ///通过样式来更新导航栏
    internal func rnb_applyNavigationBarStyle(style:RNBNavigationBarStyle, applyImmediatelly:Bool, animatedOnly:Bool?) {
        rnblog("开始应用导航栏样式")
        let animated:Bool
        let nonanimated:Bool
        if let only = animatedOnly {
            animated = only
            nonanimated = !only
        }else {
            animated = true
            nonanimated = true
        }

        if animated {
            self.rnbnav_setNavigationBarAlpha(setting: style.alphaSetting)
            self.rnbnav_setNavigationBarBackgroundAlpha(setting: style.backgroundAlphaSetting)
            self.rnbnav_setNavigationBarBackgroundColor(setting: style.backgroundColorSetting)
            self.rnbnav_setNavigationBarForegroundColor(setting: style.foregroundColorSetting)
            self.rnbnav_setNavigationBarShadowViewHidden(setting: style.shadowViewHiddenSetting)
            if applyImmediatelly {
                self.navigationBar.applyShadowHiddenImmediately()
            }
        }
        if nonanimated {
            self.rnbnav_setNavigationBarTintColor(setting: style.tintColorSetting)
            self.rnbnav_setNavigationBarTitleColor(setting: style.titleColorSetting)
            self.rnbnav_setStatusBarStyle()
            if applyImmediatelly {
                rnblog("立刻应用样式")
                self.navigationBar.applyTintColorImmediatelly()
                self.navigationBar.applyTitleColorImmediatelly()
            }
        }

    }

    ///当没有交互变化的时候调用这个方法来更新导航栏的样式, 只需要关心toVC的样式即可, 无需关心fromVC
    internal func rnb_applyNavigationBarStyleUninteractively(coordinator: UIViewControllerTransitionCoordinator) {
        guard let toController = coordinator.viewController(forKey: .to) else {return}
        rnblog("非交互状态下应用导航栏样式, to: \(String(describing: topViewController))")
        if coordinator.isAnimated {
            coordinator.animate(alongsideTransition: { (_) in
                rnblog("非交互状态下应用导航栏样式动画执行")
                let toStyle = toController.rnb_navigationBarStyleForTransition()
                self.rnb_applyNavigationBarStyle(style: toStyle, applyImmediatelly: true, animatedOnly: nil)
            }) { (_) in
                rnblog("非交互状态动画完毕, 强制应用样式")
                let toStyle = toController.rnb_navigationBarStyleForTransition()
                self.rnb_applyNavigationBarStyle(style: toStyle, applyImmediatelly: false, animatedOnly: nil)
            }
        }else {
            rnblog("非交互状态非动画应用导航栏样式")
            let toStyle = toController.rnb_navigationBarStyleForTransition()
            self.rnb_applyNavigationBarStyle(style: toStyle, applyImmediatelly: false, animatedOnly: nil)
        }
    }

    ///在交互状态下更新导航栏样式, animatedOnly传入nil表示全部更新
    internal func rnb_applyNavigationBarStyleInteractively(fromStyle:RNBNavigationBarStyle, toStyle:RNBNavigationBarStyle, progress:CGFloat) {

        //如果from是notset, 则直接设置成to (一般不会发生这个情况, 这里只是做一个逻辑上的保证)

        if true {
            if let fromAlpha = fromStyle.alphaSetting.value {
                let toAlpha = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultAlpha, settings: toStyle.alphaSetting, self.rnb_navigationBarDefaultStyle.alphaSetting)
                let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
                self.rnbnav_setNavigationBarAlpha(setting: .setted(alpha))
            }else {
                self.rnbnav_setNavigationBarAlpha(setting: toStyle.alphaSetting)
            }
        }
        if true {
            if let fromAlpha = fromStyle.backgroundAlphaSetting.value {
                let toAlpha = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundAlpha, settings: toStyle.backgroundAlphaSetting, self.rnb_navigationBarDefaultStyle.backgroundAlphaSetting)
                let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
                self.rnbnav_setNavigationBarBackgroundAlpha(setting: .setted(alpha))
            }else {
                self.rnbnav_setNavigationBarBackgroundAlpha(setting: toStyle.backgroundAlphaSetting)
            }
        }
        if true {
            let toColor:UIColor = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultBackgroundColor, settings: toStyle.backgroundColorSetting, self.rnb_defaultNavigationBarBackgroundColorSetting)
            let fromColor:UIColor
            if case let .setted(value) = fromStyle.backgroundColorSetting {
                fromColor = value
            }else {
                fromColor = toColor.withAlphaComponent(0.0)
            }
            let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
            self.rnbnav_setNavigationBarBackgroundColor(setting: .setted(color))
        }
        if true {
            let toColor:UIColor = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultForegroundColor, settings: toStyle.foregroundColorSetting, self.rnb_defaultNavigationBarForegroundColorSetting)
            let fromColor:UIColor
            if case let .setted(value) = fromStyle.foregroundColorSetting {
                fromColor = value
            }else {
                fromColor = toColor.withAlphaComponent(0.0)
            }
            let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
            self.rnbnav_setNavigationBarForegroundColor(setting: .setted(color))
        }
        if true {
            if let fromColor = fromStyle.tintColorSetting.value {
                let toColor = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTintColor, settings: toStyle.tintColorSetting, self.rnb_navigationBarDefaultStyle.tintColorSetting)
                let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
                self.rnbnav_setNavigationBarTintColor(setting: .setted(color))
            }else {
                self.rnbnav_setNavigationBarTintColor(setting: toStyle.tintColorSetting)
            }
            self.navigationBar.applyTintColorImmediatelly()
        }
        if true {
            if let fromColor = fromStyle.titleColorSetting.value {
                let toColor = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultTitleColor, settings: toStyle.titleColorSetting, self.rnb_navigationBarDefaultStyle.titleColorSetting)
                let color = RNBHelper.calculateProgressiveColor(from: fromColor, to: toColor, progress: progress)
                self.rnbnav_setNavigationBarTitleColor(setting: .setted(color))
            }else {
                self.rnbnav_setNavigationBarTitleColor(setting: toStyle.titleColorSetting)
            }
            self.navigationBar.applyTitleColorImmediatelly()
        }
        if true {
            ///这里采用渐变来实现
            let fromAlpha:CGFloat = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden, settings: fromStyle.shadowViewHiddenSetting, self.rnb_defaultNavigationBarShadowViewHiddenSetting) ? 0 : 1
            let toAlpha:CGFloat = RNBHelper.chooseSetted(defaultValue: RXCNavigationBarTransition.defaultShadowViewHidden, settings: toStyle.shadowViewHiddenSetting, self.rnb_defaultNavigationBarShadowViewHiddenSetting) ? 0 : 1
            let alpha = RNBHelper.calculateProgressiveAlpha(from: fromAlpha, to: toAlpha, progress: progress)
            self.navigationBar.rnb_shadowView1.alpha = alpha
        }
        if true {
            self.rnbnav_setStatusBarStyle()
        }
    }

}
