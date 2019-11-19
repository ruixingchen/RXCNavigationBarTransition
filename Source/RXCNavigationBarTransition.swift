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

    ///how we filter controllers
    public enum FilterMode {
        case blackList([String]), whiteList([String]), prefix([String])
        case custom((UIViewController)->Bool)
    }
    ///过滤机制
    public static var filterMode:FilterMode = .blackList([])
    ///NavController过滤机制
    public static var navigationFilterMode:FilterMode = .blackList([])

    //下面的是默认参数, 在didLaunch里面可以设置默认参数

    public static var defaultAlpha:CGFloat = 1.0
    public static var defaultBackgroundAlpha:CGFloat = 1.0
    public static var defaultBarTintColor:UIColor = RNBHelper.systemDefaultNavigationBarBarTintColor
    public static var defaultTintColor:UIColor = RNBHelper.systemDefaultNavigationBarTintColor
    public static var defaultTitleColor:UIColor = RNBHelper.systemDefaultNavigationBarTitleColor
    public static var defaultShadowViewHidden:Bool = RNBHelper.systemDefaultNavigationBarShadowViewHidden
    public static var defaultStatusBarStyle:UIStatusBarStyle = RNBHelper.systemDefaultStatusBarStyle

    private static var started:Bool = false

    public static func start() {
        //没有做线程安全, 这里由使用者自行保证线程安全😂
        if started {return}
        started = true

        UINavigationController.rnb_startMethodExchange_navigationController()
        UIViewController.rnb_startMethodExchange_viewController()
    }

}

extension RXCNavigationBarTransition {

    ///是否应该工作在某个NavController上
    internal static func shouldWorkOnNavigationController(_ controller:UINavigationController)->Bool {
        switch controller.rnb_navigationEnabled {
        case .setted(let value):
            return value
        case .notset:
            switch navigationFilterMode {
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

    ///是否应该工作在某个Controller上, 如果某个Controller不工作, 则会使用导航栏默认样式 ?? 系统默认样式
    internal static func shouldWorkOnViewController(_ controller:UIViewController)->Bool {
        switch controller.rnb_enabled {
        case .setted(let value):
            return value
        case .notset:
            switch filterMode {
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

fileprivate extension UIViewController {
    static func rnb_startMethodExchange_viewController() {
        let needSwizzleSelectors:[Selector] = [
            #selector(viewWillAppear(_:)),
            #selector(viewDidAppear(_:)),
            #selector(viewWillDisappear(_:)),
            #selector(viewDidDisappear(_:))
        ]

        let newSelectors:[Selector] = [
            #selector(rnbsw_viewWillAppear(_:)),
            #selector(rnbsw_viewDidAppear(_:)),
            #selector(rnbsw_viewWillDisappear(_:)),
            #selector(rnbsw_viewDidDisappear(_:))
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

extension UINavigationController {
    internal static func rnb_startMethodExchange_navigationController() {
        let needSwizzleSelectors:[Selector] = [
            NSSelectorFromString("_updateInteractiveTransition:"),
            #selector(UINavigationController.pushViewController(_:animated:)),
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
