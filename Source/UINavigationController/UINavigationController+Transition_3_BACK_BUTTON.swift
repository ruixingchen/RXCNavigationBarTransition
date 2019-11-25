//
//  UINavigationController+Transition_3.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/8/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//情况3: 点击返回按钮, 系统会自动调用pop方法, 逻辑和pop一致, 无需做额外处理

//下面的代码是WRNavigationBar的遗产, 留着吧

#if (debug || DEBUG)
extension UINavigationController: UINavigationBarDelegate {

    @objc public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if RNBHelper.isOperatingSystemAtLeast(13,0,0) {
            rnblog("点击返回按钮 - iOS13")
            //在iOS13下, 只有点击左上角的时候会走这个方法, 返回true, 会自动执行pop方法, 相关的逻辑会在pop方法内执行
            return true
        }else {
            //iOS13之前需要分不同的情况来解决
            //1, 代码pop: 可以获取到coordinator, 同时initiallyInteractive为false, 无需手动pop
            //2, 手势滑动: 可以获取到coordinator, 同时initiallyInteractive为true, 无需手动pop
            //3, 点击左上角返回按钮: 无法获取到coordinator, 需要手动pop
            guard let coordinator = self.transitionCoordinator else {
                //导航栏返回按钮, 需要手动调用pop
                rnblog("点击返回按钮 - iOS13之前")
                self.popViewController(animated: true)
                return true
            }
            if coordinator.initiallyInteractive {
                //手势返回
                //手势返回的逻辑在情况2的文件中处理
                rnblog("侧滑返回触发 - iOS13之前")
                return true
            }else {
                ///代码返回
                //直接返回true即可
                rnblog("代码pop - iOS13之前")
                return true
            }
        }
    }

}
#endif
