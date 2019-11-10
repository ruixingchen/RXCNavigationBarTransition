//
//  UINavigationController+Transition_3.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/8/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//情况3: 通过点击左上角的返回按钮来pop

//这个情况最为复杂

//在iOS13之前, 代码pop, 滑动返回, 都会走本方法, iOS13则只有点击左上角会走本方法

extension UINavigationController: UINavigationBarDelegate {

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if RNBHelper.isOperatingSystemAtLeast(OperatingSystemVersion.init(majorVersion: 13, minorVersion: 0, patchVersion: 0)) {
            //在iOS13下, 只有点击左上角的时候会走这个方法
            //在iOS13下, 这个函数返回true, 会直接进行pop, 无需自己调用pop方法, 逻辑移到了pop方法内
            return true
        }else {
            //iOS13之前需要分不同的情况来解决
            //1, 代码pop: 可以获取到coordinator, 同时initiallyInteractive为false, 无需额外pop
            //2, 手势滑动: 可以获取到coordinator, 同时initiallyInteractive为true, 无需额外pop
            //3, 点击左上角返回按钮: 无法获取到coordinator, 需要手动pop
            guard let coordinator = self.transitionCoordinator else {
                //左上角返回
                self.popViewController(animated: true)
                return false
            }
            if coordinator.initiallyInteractive {
                //手势返回
                //手势返回的逻辑在情况2的文件中处理
                return true
            }else {
                ///代码返回
                //直接返回true即可
                return true
            }
        }
    }

}
