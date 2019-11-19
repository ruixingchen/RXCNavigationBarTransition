//
//  UIViewController+Transition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    internal func rnb_isNavRootViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.viewControllers.first === self
    }

    internal func rnb_isNavTopViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.topViewController === self
    }

    internal func rnb_isNavLastViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.viewControllers.last === self
    }

    internal func rnb_isNavOnlyViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.viewControllers.count == 1 && nav.viewControllers.first == self
    }

    internal func isEmbededInNavigationController()->Bool {
        return self.navigationController != nil
    }

}

extension UIViewController {

    internal struct Key {
        static var rnb_enabled:String = "rnb_enabled"
        static var rnb_navigationBarStyle:String = "rnb_navigationBarStyle"
        static var rnb_navigationBarStyleSavedBeforeTransition:String = "rnb_navigationBarStyleSavedBeforeTransition"
        static var rnb_visibility:String = "rnb_visibility"
        //static var rnb_lifeCycle:String = "rnb_lifeCycle"
    }

    ///可见性
    internal enum RNBVisibility {
        case none
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear

        func willOrDidAppear()->Bool {
            return self == .willAppear || self == .didAppear
        }
    }

    ///生命周期状态, 只枚举了显示的过程, 由于一个controller可能会在消失后再次显示, 这里不枚举消失
//    internal enum RNBLifeCycle:Int {
//        case inited = 0
//        case loadView
//        case viewDidLoad
//        case willAppear
//        case willLayoutSubviews
//        case didLayoutSubviews
//        case didAppear
//    }

    ///当前VC的可见性
    internal var rnb_visibility:RNBVisibility {
        get {
            var value:RNBVisibility! = objc_getAssociatedObject(self, &Key.rnb_visibility) as? RNBVisibility
            if value == nil {
                value = RNBVisibility.none
                self.rnb_visibility = value
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_visibility, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///是否对当前VC启用(仅在当前VC作为一个NavController的子VC时)
    public var rnb_enabled:RNBSetting<Bool> {
        get {
            if let value = objc_getAssociatedObject(self, &Key.rnb_enabled) as? RNBSetting<Bool> {
                return value
            }else {
                return RNBSetting.notset
            }
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_enabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///用户设定的导航栏样式保存在这里
    internal var rnb_navigationBarStyle: RNBNavigationBarStyle {
        get {
            var style:RNBNavigationBarStyle! = objc_getAssociatedObject(self, &Key.rnb_navigationBarStyle) as? RNBNavigationBarStyle
            if style == nil {
                style = RNBNavigationBarStyle.notset()
                self.rnb_navigationBarStyle = style
            }
            return style
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_navigationBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///进行变换之前, 将当前的导航栏样式存储到这个变量中, 下次切换回来的时候可以继续显示
    internal var rnb_navigationBarStyleSavedBeforeTransition: RNBNavigationBarStyle? {
        get {
            return objc_getAssociatedObject(self, &Key.rnb_navigationBarStyleSavedBeforeTransition) as? RNBNavigationBarStyle
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_navigationBarStyleSavedBeforeTransition, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///如果有保存的样式, 优先返回保存的样式, 否则返回用户设置的样式
    internal func rnb_navigationBarStyleForTransition()->RNBNavigationBarStyle {
        if let saved = self.rnb_navigationBarStyleSavedBeforeTransition {
            return saved
        }else if RXCNavigationBarTransition.shouldWorkOnViewController(self) {
            return self.rnb_navigationBarStyle
        }else {
            //这个VC被禁用了, 直接返回未设置即可
            return RNBNavigationBarStyle.notset()
        }
    }

}

extension UIViewController {

    @objc func rnbsw_viewWillAppear(_ animated: Bool) {
        self.rnb_visibility = .willAppear
        rnblog("viewWillAppear: \(self.title ?? "no title") @ \(self.description)")
//        let style = self.rnb_navigationBarStyleForTransition()
//        self.navigationController?.updateNavigationBarStyle(style: style, animatable: false)

        self.rnbsw_viewWillAppear(animated)
    }

    @objc func rnbsw_viewDidAppear(_ animated: Bool) {
        self.rnb_visibility = .didAppear
        rnblog("viewDidAppear: \(self.title ?? "no title") @ \(self.description)")
        if let nav = self as? UINavigationController, nav.navigationController == nil {
            ///如果是一个NavController, 给侧滑返回手势添加一个target来追踪他的状态
            if RXCNavigationBarTransition.debugMode {
                if let g = nav.interactivePopGestureRecognizer, !nav.rnb_interactivePopGestureRecognizerTargetAdded {
                    nav.rnb_interactivePopGestureRecognizerTargetAdded = true
                    g.addTarget(nav, action: #selector(UINavigationController.onInteractivePopGestureRecognizer(sender:)))
                }
            }
        }
        self.rnbsw_viewDidAppear(animated)
    }

    @objc func rnbsw_viewWillDisappear(_ animated: Bool) {
        self.rnb_visibility = .willDisappear
        rnblog("viewWillDisappear: \(self.title ?? "no title") @ \(self.description)")
        self.rnbsw_viewWillDisappear(animated)
    }

    @objc func rnbsw_viewDidDisappear(_ animated: Bool) {
        self.rnb_visibility = .didDisappear
        rnblog("viewDidDisappear: \(self.title ?? "no title") @ \(self.description)")
        self.rnbsw_viewDidDisappear(animated)
    }

}

//MARK: - Public Interface
extension UIViewController {

    public var rnb_navigationBarAlpha: RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarStyle.alphaSetting
        }
        set {
            self.rnb_navigationBarStyle.alphaSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.alphaSetting = self.rnb_navigationBarStyle.alphaSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarAlpha(setting: self.rnb_navigationBarStyle.alphaSetting)
            }
        }
    }

    public var rnb_navigationBarBackgroundAlpha: RNBSetting<CGFloat> {
        get {
            return self.rnb_navigationBarStyle.backgroundAlphaSetting
        }
        set {
            self.rnb_navigationBarStyle.backgroundAlphaSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.backgroundAlphaSetting = self.rnb_navigationBarStyle.backgroundAlphaSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarBackgroundAlpha(setting: self.rnb_navigationBarStyle.backgroundAlphaSetting)
            }
        }
    }

    public var rnb_navigationBarBarTintColor: RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarStyle.barTintColorSetting
        }
        set {
            self.rnb_navigationBarStyle.barTintColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.barTintColorSetting = self.rnb_navigationBarStyle.barTintColorSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarBarTintColor(setting: self.rnb_navigationBarStyle.barTintColorSetting)
            }
        }
    }

    public var rnb_navigationBarTintColor: RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarStyle.tintColorSetting
        }
        set {
            self.rnb_navigationBarStyle.tintColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.tintColorSetting = self.rnb_navigationBarStyle.tintColorSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarTintColor(setting: self.rnb_navigationBarStyle.tintColorSetting)
            }
        }
    }

    public var rnb_navigationBarTitleColor: RNBSetting<UIColor> {
        get {
            return self.rnb_navigationBarStyle.titleColorSetting
        }
        set {
            self.rnb_navigationBarStyle.titleColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.titleColorSetting = self.rnb_navigationBarStyle.titleColorSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarTitleColor(setting: self.rnb_navigationBarStyle.titleColorSetting)
            }
        }
    }

    public var rnb_navigationBarShadowViewHidden: RNBSetting<Bool> {
        get {
            return self.rnb_navigationBarStyle.shadowViewHiddenSetting
        }
        set {
            self.rnb_navigationBarStyle.shadowViewHiddenSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.shadowViewHiddenSetting = self.rnb_navigationBarStyle.shadowViewHiddenSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setNavigationBarShadowViewHidden(setting: self.rnb_navigationBarStyle.shadowViewHiddenSetting)
            }
        }
    }

    public var rnb_statusBarStyle: RNBSetting<UIStatusBarStyle> {
        get {
            return self.rnb_navigationBarStyle.statusBarStyleSetting
        }
        set {
            self.rnb_navigationBarStyle.statusBarStyleSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.statusBarStyleSetting = self.rnb_navigationBarStyle.statusBarStyleSetting
            if self.rnb_isNavOnlyViewController() || ( self.rnb_isNavLastViewController() && self.rnb_visibility == .didAppear) {
                self.navigationController?.rnbnav_setStatusBarStyle()
            }
        }
    }

}
