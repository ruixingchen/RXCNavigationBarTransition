//
//  UINavigationController+RNBExtension.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/20/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationController {

    /*
    ///正在进行pop的VC, 通过正常的API是获取不到的, 只能采用土办法
    public var poppingViewController:UIViewController? {
        guard let UINavigationTransitionView = NSClassFromString("UINavigationTransitionView") else {
            assertionFailure("没有找到 UINavigationTransitionView 类")
            return nil
        }
        guard let transitionView = self.view.subviews.first(where: {$0.isMember(of: UINavigationTransitionView)}) else {
            assertionFailure("没有找到 transitionView")
            return nil
        }
        guard let UIViewControllerWrapperView = NSClassFromString("UIViewControllerWrapperView") else {
            assertionFailure("没有找到 UIViewControllerWrapperView 类")
            return nil
        }
        guard let wrapperView = transitionView.subviews.first(where: {$0.isMember(of: UIViewControllerWrapperView)}) else {
            //这里完全有可能是nil, 无需assert
            return nil
        }
        guard let _UIParallaxDimmingView = NSClassFromString("_UIParallaxDimmingView") else {
            assertionFailure("找不到 _UIParallaxDimmingView 类")
            return nil
        }

        let dimmingViewClosure:()->UIView? = {
            for i in wrapperView.subviews {
                for j in i.subviews {
                    if j.isMember(of: _UIParallaxDimmingView) {
                        return j
                    }
                }
            }
            return nil
        }
        guard let dimmingView = dimmingViewClosure() else {
            assertionFailure("无法找到 _UIParallaxDimmingView")
            return nil
        }
        for i in dimmingView.subviews {
            if let vc = RNBHelper.findClosestViewController(for: i) {
                if vc != self && !self.children.contains(vc) {
                    return vc
                }
            }
        }
        return nil
    }
     */

}
