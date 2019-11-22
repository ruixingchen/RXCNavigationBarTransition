//
//  RXCNavigationBarTransition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public final class RXCNavigationBarTransition {

    #if (debug || DEBUG)
    public static var debugMode:Bool = true
    #else
    public static var debugMode:Bool = false
    #endif

    public enum WorkingMode {
        case blackList([String]), whiteList([String]), prefix([String])
        case custom((UIViewController)->Bool)
    }

    public static var workingMode:WorkingMode = .blackList([])

    public static var navigationWorkingMode:WorkingMode = .blackList([])

    //下面的是默认样式, 最好在在didLaunch里面设置, 当第一个Nav已经显示后最好就不要改了

    public static var defaultAlpha:CGFloat = 1.0
    public static var defaultBackgroundAlpha:CGFloat = 1.0
    public static var defaultBackgroundColor:UIColor = RNBHelper.systemDefaultNavigationBarBackgroundColor
    public static var defaultForegroundColor:UIColor = RNBHelper.systemDefaultNavigationBarForegroundColor
    public static var defaultTintColor:UIColor = RNBHelper.systemDefaultNavigationBarTintColor
    public static var defaultTitleColor:UIColor = RNBHelper.systemDefaultNavigationBarTitleColor
    public static var defaultShadowViewHidden:Bool = RNBHelper.systemDefaultNavigationBarShadowViewHidden
    public static var defaultStatusBarStyle:UIStatusBarStyle = RNBHelper.systemDefaultStatusBarStyle

    private static var started:Bool = false

    ///开始方法交换的入口, 需要在didLaunch中第一个VC初始化之前调用, 没有做线程安全, 这里由使用者自行保证线程安全😂
    public static func start() {
        if started {return}
        started = true
        UINavigationBar.rnb_startMethodExchange()
        UINavigationController.rnb_startMethodExchange_navigationController()
        UIViewController.rnb_startMethodExchange_viewController()
    }

}

extension RXCNavigationBarTransition {

    ///是否应该工作在某个NavController上
    internal static func shouldWorkOnNavigationController(_ controller:UINavigationController)->Bool {
        if let enabled = controller.rnb_navigationEnabled {
            return enabled
        }else {
            switch navigationWorkingMode {
            case .blackList(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return !list.contains(controllerClassName)
            case .whiteList(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return list.contains(controllerClassName)
            case .prefix(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return list.contains(where: {controllerClassName.hasPrefix($0)})
            case .custom(let closure):
                return closure(controller)
            }
        }
    }

    ///是否应该工作在某个Controller上, 如果某个Controller不工作, 则会使用 (导航栏默认样式 ?? 系统默认样式)
    internal static func shouldWorkOnViewController(_ controller:UIViewController)->Bool {
        if let enabled = controller.rnb_enabled {
            return enabled
        }else {
            switch workingMode {
            case .blackList(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return !list.contains(controllerClassName)
            case .whiteList(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return list.contains(controllerClassName)
            case .prefix(let list):
                let controllerClassName = String.init(describing: controller.classForCoder)
                return list.contains(where: {controllerClassName.hasPrefix($0)})
            case .custom(let closure):
                return closure(controller)
            }
        }
    }
}

fileprivate extension UINavigationBar {

    static func rnb_startMethodExchange() {
        let needSwizzleSelectors:[Selector] = [
            #selector(layoutSubviews)
        ]
        for i in needSwizzleSelectors.enumerated() {
            guard let originalMethod = class_getInstanceMethod(self, i.element) else {
                assertionFailure("method exchange failed, origin selector not found:\(i.element)")
                continue
            }
            guard let newSelector = class_getInstanceMethod(self, Selector("rnbsw_\(i.element.description)")) else {
                assertionFailure("method exchange failed, new selector not found: rnbsw_\(i.element.description)")
                continue
            }
            method_exchangeImplementations(originalMethod, newSelector)
        }
    }

}

fileprivate extension UIViewController {
    static func rnb_startMethodExchange_viewController() {
        let needSwizzleSelectors:[Selector] = [
            #selector(viewWillAppear(_:)),
            #selector(viewDidAppear(_:)),
            #selector(viewWillDisappear(_:)),
            #selector(viewDidDisappear(_:))
        ]
        for i in needSwizzleSelectors.enumerated() {
            guard let originalMethod = class_getInstanceMethod(self, i.element) else {
                assertionFailure("method exchange failed, origin selector not found:\(i.element)")
                continue
            }
            guard let newSelector = class_getInstanceMethod(self, Selector("rnbsw_\(i.element.description)")) else {
                assertionFailure("method exchange failed, new selector not found: rnbsw_\(i.element.description)")
                continue
            }
            method_exchangeImplementations(originalMethod, newSelector)
        }
    }
}

extension UINavigationController {
    internal static func rnb_startMethodExchange_navigationController() {
        let needSwizzleSelectors:[Selector] = [
            NSSelectorFromString("_updateInteractiveTransition:"),
            #selector(UINavigationController.pushViewController(_:animated:)),
            //这里的popViewController(animated:)不可以使用description来生成对应的rnbsw, 所以这个方法只能手动指定了
            #selector(UINavigationController.popViewController(animated:)),
            #selector(UINavigationController.popToViewController(_:animated:)),
            #selector(UINavigationController.popToRootViewController(animated:))
        ]
        let newSelectors:[Selector] = [
            #selector(rnbsw__updateInteractiveTransition(_:)),
            #selector(rnbsw_pushViewController(_:animated:)),
            #selector(rnbsw_popViewController(animated:)),
            #selector(rnbsw_popToViewController(_:animated:)),
            #selector(rnbsw_popToRootViewController(animated:))
        ]

        for i in needSwizzleSelectors.enumerated() {
            guard let originalMethod = class_getInstanceMethod(self, i.element) else {
                assertionFailure("method exchange failed, origin selector not found:\(i.element)")
                continue
            }
            guard let newSelector = class_getInstanceMethod(self, newSelectors[i.offset]) else {
                assertionFailure("method exchange failed, new selector not found:\(newSelectors[i.offset])")
                continue
            }
            method_exchangeImplementations(originalMethod, newSelector)
        }
    }
}
