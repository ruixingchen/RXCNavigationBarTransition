//
//  UINavigationController+Transition_1.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/8/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//MARK: - 情况1, 通过调用方法直接push或者pop
//调用方法来push/pop的情况下只要在真的push/pop前保存当前样式即可

extension UINavigationController {

    @objc func rnbsw_pushViewController(_ viewController: UIViewController, animated: Bool) {
        ///PUSH的时候, 先保存样式到当前的TopVC, 之后开始PUSH, 动画生效的时候, VC已经执行完毕了willAppear
        rnblog("导航push \(viewController)")
        self.topViewController?.rnb_navigationBarStyleSavedBeforeTransition = self.navigationBar.rnb_currentStyle()
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            self.rnbsw_pushViewController(viewController, animated: animated)
            return
        }

        self.rnbsw_pushViewController(viewController, animated: animated)

        if let coordinator = viewController.transitionCoordinator {
            self.rnb_applyNavigationBarStyleUninteractively(coordinator: coordinator)
        }else {
            //非animated
            //这里必须async, 让push方法完全执行
            DispatchQueue.main.async {
                if self.viewControllers.count == 1 {
                    //push之后只有一个VC, 表示这是初始化时候的push, 这个时候navBar尚未初始化, 我们无须处理
                    return
                }
                if let vc = self.topViewController {
                    let style = vc.rnb_navigationBarStyleForTransition()
                    self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false, animatedOnly: nil)
                }else {
                    if RXCNavigationBarTransition.debugMode {
                        assertionFailure("无法获取到topViewController")
                    }
                }
            }
        }
    }

    @objc func rnbsw_popViewController(animated:Bool)->UIViewController? {
        rnblog("导航pop")
        self.topViewController?.rnb_navigationBarStyleSavedBeforeTransition = self.navigationBar.rnb_currentStyle()
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            let vc = self.rnbsw_popViewController(animated: animated)
            return vc
        }
        let popVC = self.rnbsw_popViewController(animated: animated)
        if let coordinator = self.transitionCoordinator {
            if coordinator.initiallyInteractive {
                //手势滑动返回导致的pop调用, 无需处理导航栏样式
                rnblog("本次pop是侧滑pop")
            }else {
                //非交互式的pop, 代码返回或者
                self.rnb_applyNavigationBarStyleUninteractively(coordinator: coordinator)
            }
        }else {
            //无法获取coordinator, 可能是非animated, 直接应用样式
            //async, 让pop方法完全执行
            DispatchQueue.main.async {
                if let vc = self.topViewController {
                    let style = vc.rnb_navigationBarStyleForTransition()
                    self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false, animatedOnly: nil)
                }else {
                    if RXCNavigationBarTransition.debugMode {
                        assertionFailure("无法获取到topViewController")
                    }
                }
            }
        }

        return popVC
    }

    @discardableResult
    @objc func rnbsw_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        rnblog("导航popTo \(viewController)")
        self.topViewController?.rnb_navigationBarStyleSavedBeforeTransition = self.navigationBar.rnb_currentStyle()
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            return self.rnbsw_popToViewController(viewController, animated: animated)
        }

        let vcs = self.rnbsw_popToViewController(viewController, animated: animated)

        if let coordinator = self.transitionCoordinator {
            self.rnb_applyNavigationBarStyleUninteractively(coordinator: coordinator)
        }else {
            //async, 让pop方法完全执行
            DispatchQueue.main.async {
                if let vc = self.topViewController {
                    let style = vc.rnb_navigationBarStyleForTransition()
                    self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false, animatedOnly: nil)
                }else {
                    if RXCNavigationBarTransition.debugMode {
                        assertionFailure("无法获取到topViewController")
                    }
                }
            }
        }

        return vcs
    }

    @discardableResult
    @objc func rnbsw_popToRootViewController(animated: Bool) -> [UIViewController]? {
        rnblog("导航popToRoot")
        self.topViewController?.rnb_navigationBarStyleSavedBeforeTransition = self.navigationBar.rnb_currentStyle()
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            return self.rnbsw_popToRootViewController(animated: animated)
        }

        let vcs:[UIViewController]? = self.rnbsw_popToRootViewController(animated: animated)

        if let coordinator = self.transitionCoordinator {
            self.rnb_applyNavigationBarStyleUninteractively(coordinator: coordinator)
        }else {
            //async, 让pop方法完全执行
            DispatchQueue.main.async {
                if let vc = self.topViewController {
                    let style = vc.rnb_navigationBarStyleForTransition()
                    self.rnb_applyNavigationBarStyle(style: style, applyImmediatelly: false, animatedOnly: nil)
                }else {
                    if RXCNavigationBarTransition.debugMode {
                        assertionFailure("无法获取到topViewController")
                    }
                }
            }
        }

        return vcs
    }

}
