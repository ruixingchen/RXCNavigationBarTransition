//
//  UINavigationController+Transition_2.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/8/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//MARK: - 情况2, 滑动手势返回

//滑动返回中间取消了交互行为的处理在情况3的代码中
//给手势添加一个target, 在这个target接收到began消息的时候记录当前样式

extension UINavigationController {

    @objc internal func rnbsw__updateInteractiveTransition(_ percentComplete: CGFloat) {
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            self.rnbsw__updateInteractiveTransition(percentComplete)
            return
        }

        self.rnbsw__updateInteractiveTransition(percentComplete)

        if let coordinator = self.transitionCoordinator {
            let fromVC = coordinator.viewController(forKey: .from)
            guard let toVC = coordinator.viewController(forKey: .to) else {return}
            let fromStyle = fromVC?.rnb_navigationBarStyleForTransition() ?? RNBNavigationBarStyle.notsetted()
            let toStyle = toVC.rnb_navigationBarStyleForTransition()
            self.rnb_updateNavigationBarStyleInteractively(fromStyle: fromStyle, toStyle: toStyle, progress: percentComplete)
        }
    }

    ///当前侧滑手势额外的Target是否已经添加
    internal var rnb_interactivePopGestureRecognizerTargetAdded:Bool {
        get {return objc_getAssociatedObject(self, &NavKey.rnb_interactivePopGestureRecognizerTargetAdded) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &NavKey.rnb_interactivePopGestureRecognizerTargetAdded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    @objc internal func onInteractivePopGestureRecognizer(sender:AnyObject?) {
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {return}
        guard let gesture = sender as? UIGestureRecognizer else {return}
        #if (debug || DEBUG)
        switch gesture.state {
        case .possible:
            rnblog("导航侧滑手势状态: possible")
        case .began:
            rnblog("导航侧滑手势状态: began")
        case .changed:
            //rnblog("导航侧滑手势状态: changed")
            break
        case .ended:
            rnblog("导航侧滑手势状态: ended")
        case .failed:
            rnblog("导航侧滑手势状态: failed")
        case .cancelled:
            rnblog("导航侧滑手势状态: cancelled")
        @unknown default:
            rnblog("导航侧滑手势状态: 未知")
        }
        #endif

        switch gesture.state {
        case .began:
            //保存当前的状态栏样式
            self.rnb_saveNavigationBarStyleToTopViewController()
            guard let coordinator = self.transitionCoordinator else {return}
            guard let toVC = coordinator.viewController(forKey: .to)else {return}
            guard let fromVC = coordinator.viewController(forKey: .from) else {return}

            coordinator.notifyWhenInteractionChanges {[weak self] (context) in
                //当交互状态发生变化的时候, 表示用户在侧滑过程中抬起了手指, 需要根据context的状态判断是继续前进还是返回原VC
                //这里使用coordinator.animate不会生效, 自己用动画实现过渡
                if context.isCancelled {
                    rnblog("侧滑中断 - 取消")
                    //退回fromVC
                    UIView.animate(withDuration: coordinator.transitionDuration) {
                        rnblog("侧滑中断 - 取消 - 动画执行")
                        self?.rnb_updateNavigationBarStyle(style: fromVC.rnb_navigationBarStyleForTransition(), applyImmediatelly: true)
                    }
                }else {
                    //继续变换到toVC
                    rnblog("侧滑中断 - 继续")
                    UIView.animate(withDuration: coordinator.transitionDuration) {
                        rnblog("侧滑中断 - 继续 - 动画执行")
                        self?.rnb_updateNavigationBarStyle(style: toVC.rnb_navigationBarStyleForTransition(), applyImmediatelly: true)
                    }
                }
            }
        default:
            break
        }
    }

}
