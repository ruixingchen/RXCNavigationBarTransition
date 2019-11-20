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
        static var rnb_didAppear:String = "rnb_didAppear"
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

    ///生命周期, 主要用于记录当前VC是否已经调用过某些生命周期方法
    /*
    internal enum RNBLifeCycle:Int {
        case inited = 0
        case loadView
        case viewDidLoad
        case willAppear
        case willLayoutSubviews
        case didLayoutSubviews
        case didAppear
    }
     */

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

    ///这个VC是否已经调用过了didAppear
    internal var rnb_didAppear:Bool {
        get {
            return objc_getAssociatedObject(self, &Key.rnb_didAppear) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_didAppear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /*
    ///当前VC的生命周期
    internal var rnb_lifeCycle:RNBLifeCycle {
        get {
            var value:RNBLifeCycle! = objc_getAssociatedObject(self, &Key.rnb_lifeCycle) as? RNBLifeCycle
            if value == nil {
                value = RNBLifeCycle.inited
                self.rnb_lifeCycle = value
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_lifeCycle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
     */

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
        self.rnb_didAppear = true
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

    //设置样式的时候
    //1, 如果这个VC是当前正在显示的VC, 那么直接修改样式
    //2, 如果这个VC是唯一的VC, 且这个VC尚未进入didAppear流程, 那么直接修改样式, 对应初始化时候的场景, 同时也解决了当Nav有两个VC, 进行pop的时候会首先将第二个VC移出栈, 导致第一个VC认为自己是唯一的VC而强制修改样式的问题
    //其他情况下则只记录不修改, 当这个VC被显示的时候会自动将保存的样式应用到navBar上

    ///当前是否可以更新NavBar的样式, 只有两种情况下可以立刻更新样式, 1: 正在显示, 2: Root页初始化
    internal func canUpdateNavigationBarStyle()->Bool {
        let initialPage = (self.rnb_isNavOnlyViewController() && !self.rnb_didAppear)
        let visiblePage = (self.rnb_isNavTopViewController() && self.rnb_visibility == .didAppear)
        return initialPage || visiblePage
    }

    internal func rnb_setNavigationBarAlpha(_ setting:RNBSetting<CGFloat>) {
        self.rnb_navigationBarStyle.alphaSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.alphaSetting = self.rnb_navigationBarStyle.alphaSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarAlpha(setting: self.rnb_navigationBarStyle.alphaSetting)
        }
    }
    public func rnb_setNavigationBarAlpha(_ value:CGFloat) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarAlpha(setting)
    }
    public func rnb_clearNavigationBarAlphaSetting() {
        self.rnb_setNavigationBarAlpha(.notset)
    }
    public func rnb_settedNavigationBarAlphaSetting()->RNBSetting<CGFloat> {
        return self.rnb_navigationBarStyle.alphaSetting
    }

    internal func rnb_setNavigationBarBackgroundAlpha(_ setting:RNBSetting<CGFloat>) {
        self.rnb_navigationBarStyle.backgroundAlphaSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.backgroundAlphaSetting = self.rnb_navigationBarStyle.backgroundAlphaSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarBackgroundAlpha(setting: self.rnb_navigationBarStyle.backgroundAlphaSetting)
        }
    }
    public func rnb_setNavigationBarBackgroundAlpha(_ value:CGFloat) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarBackgroundAlpha(setting)
    }
    public func rnb_clearNavigationBarBackgroundAlphaSetting() {
        self.rnb_setNavigationBarBackgroundAlpha(.notset)
    }
    public func rnb_settedNavigationBarBackgroundAlphaSetting()->RNBSetting<CGFloat> {
        return self.rnb_navigationBarStyle.backgroundAlphaSetting
    }

    internal func rnb_setNavigationBarBarTintColor(_ setting:RNBSetting<UIColor?>) {
        self.rnb_navigationBarStyle.barTintColorSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.barTintColorSetting = self.rnb_navigationBarStyle.barTintColorSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarBarTintColor(setting: self.rnb_navigationBarStyle.barTintColorSetting)
        }
    }
    public func rnb_setNavigationBarBarTintColor(_ value:UIColor?) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarBarTintColor(setting)
        #if (debug || DEBUG)
        if let color = value {
            let tuple = color.rnb_rgbaTuple()
            if tuple.a == 0 {
                print("使用了alpha为0的颜色可能会导致未知的动画效果, 慎为之")
            }
        }
        #endif
    }
    public func rnb_clearNavigationBarBarTintColorSetting() {
        self.rnb_setNavigationBarBarTintColor(.notset)
    }
    public func rnb_settedNavigationBarBarTintColorSetting()->RNBSetting<UIColor?> {
        return self.rnb_navigationBarStyle.barTintColorSetting
    }

    internal func rnb_setNavigationBarTintColor(_ setting:RNBSetting<UIColor>) {
        self.rnb_navigationBarStyle.tintColorSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.tintColorSetting = self.rnb_navigationBarStyle.tintColorSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarTintColor(setting: self.rnb_navigationBarStyle.tintColorSetting)
        }
    }
    public func rnb_setNavigationBarTintColor(_ value:UIColor) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarTintColor(setting)
    }
    public func rnb_clearNavigationBarTintColorSetting() {
        self.rnb_setNavigationBarTintColor(.notset)
    }
    public func rnb_settedNavigationBarTintColorSetting()->RNBSetting<UIColor> {
        return self.rnb_navigationBarStyle.tintColorSetting
    }

    internal func rnb_setNavigationBarTitleColor(_ setting:RNBSetting<UIColor>) {
        self.rnb_navigationBarStyle.titleColorSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.titleColorSetting = self.rnb_navigationBarStyle.titleColorSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarTitleColor(setting: self.rnb_navigationBarStyle.titleColorSetting)
        }
    }
    public func rnb_setNavigationBarTitleColor(_ value:UIColor) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarTitleColor(setting)
    }
    public func rnb_clearNavigationBarTitleColorSetting() {
        self.rnb_setNavigationBarTitleColor(.notset)
    }
    public func rnb_settedNavigationBarTitleColorSetting()->RNBSetting<UIColor> {
        return self.rnb_navigationBarStyle.titleColorSetting
    }

    internal func rnb_setNavigationBarShadowViewHidden(_ setting:RNBSetting<Bool>) {
        self.rnb_navigationBarStyle.shadowViewHiddenSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.shadowViewHiddenSetting = self.rnb_navigationBarStyle.shadowViewHiddenSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setNavigationBarShadowViewHidden(setting: self.rnb_navigationBarStyle.shadowViewHiddenSetting)
        }
    }
    public func rnb_setNavigationBarShadowViewHidden(_ value:Bool) {
        let setting = RNBSetting.setted(value)
        self.rnb_setNavigationBarShadowViewHidden(setting)
    }
    public func rnb_clearNavigationBarShadowViewHiddenSetting() {
        self.rnb_setNavigationBarShadowViewHidden(.notset)
    }
    public func rnb_settedNavigationBarShadowViewHiddenSetting()->RNBSetting<Bool> {
        return self.rnb_navigationBarStyle.shadowViewHiddenSetting
    }

    internal func rnb_setStatusBarStyle(_ setting:RNBSetting<UIStatusBarStyle>) {
        self.rnb_navigationBarStyle.statusBarStyleSetting = setting
        self.rnb_navigationBarStyleSavedBeforeTransition?.statusBarStyleSetting = self.rnb_navigationBarStyle.statusBarStyleSetting
        if self.canUpdateNavigationBarStyle() {
            self.navigationController?.rnbnav_setStatusBarStyle()
        }
    }
    public func rnb_setStatusBarStyle(_ value:UIStatusBarStyle) {
        let setting = RNBSetting.setted(value)
        self.rnb_setStatusBarStyle(setting)
    }
    public func rnb_clearStatusBarStyleSetting() {
        self.rnb_setStatusBarStyle(.notset)
    }
    public func rnb_settedStatusBarStyleSetting()->RNBSetting<UIStatusBarStyle> {
        return self.rnb_navigationBarStyle.statusBarStyleSetting
    }
}
