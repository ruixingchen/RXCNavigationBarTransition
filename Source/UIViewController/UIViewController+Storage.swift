//
//  UIViewController+Transition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    internal struct Key {
        static var rnb_enabled:String = "rnb_enabled"
        static var rnb_navigationBarStyle:String = "rnb_navigationBarStyle"
        static var rnb_navigationBarStyleSavedBeforeTransition:String = "rnb_navigationBarStyleSavedBeforeTransition"
        static var rnb_visibility:String = "rnb_visibility"

        static var rnb_viewDidLoad_called = "rnb_viewDidLoad_called"
        static var rnb_viewDidAppear_called:String = "rnb_viewDidAppear_called"
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

    //TODO: - 考虑记录所有生命周期方法的调用情况
    ///这个VC是否已经调用过了didAppear
    internal var rnb_viewDidAppear_called:Bool {
        get {
            return objc_getAssociatedObject(self, &Key.rnb_viewDidAppear_called) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_viewDidAppear_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    internal var rnb_viewDidLoad_called:Bool {
        get {
            return objc_getAssociatedObject(self, &Key.rnb_viewDidLoad_called) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_viewDidLoad_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    ///是否对当前VC启用(仅在当前VC作为一个NavController的子VC时)
    public var rnb_enabled:Bool? {
        get {
            return objc_getAssociatedObject(self, &Key.rnb_enabled) as? Bool
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

    ///进行transition之前, 将当前的导航栏样式存储到这个变量中, 下次切换回来的时候可以继续显示, 这样即使用户手动修改了navBar的一些样式, 我们下次回来的时候仍然可以正确显示
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
