//
//  UINavigationController+Transition_2.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/8/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//MARK: - 情况2, 滑动手势返回

//方案1: 给手势添加一个target, 在这个target接收到began消息的时候记录当前样式, 但是如果用户使用其他方法触发侧滑返回就么得办法了, 某些时候这个手势不可靠, 不使用这个方案
//方案2: 由于侧滑返回的时候系统会自动调用一次pop方法, 在pop方法中保存当前导航栏样式, updateInteractiveTransition中只执行交互更新导航栏的逻辑

extension UINavigationController {

    ///当前侧滑手势额外的Target是否已经添加
    internal var rnb_interactivePopGestureRecognizerTargetAdded:Bool {
        get {return objc_getAssociatedObject(self, &NavKey.rnb_interactivePopGestureRecognizerTargetAdded) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &NavKey.rnb_interactivePopGestureRecognizerTargetAdded, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    ///存储侧滑的coordinator
    internal var updateInteractiveTransitionCoordinator:UIViewControllerTransitionCoordinator? {
        get {return objc_getAssociatedObject(self, &NavKey.updateInteractiveTransitionCoordinator) as? UIViewControllerTransitionCoordinator}
        set {objc_setAssociatedObject(self, &NavKey.updateInteractiveTransitionCoordinator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    @objc internal func rnbsw__updateInteractiveTransition(_ percentComplete: CGFloat) {
        //这个方法会在用户侧滑期间持续被调用

        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {
            self.rnbsw__updateInteractiveTransition(percentComplete)
            return
        }

        self.rnbsw__updateInteractiveTransition(percentComplete)

        if let coordinator = self.transitionCoordinator {
            guard let fromVC = coordinator.viewController(forKey: .from) else {return}
            guard let toVC = coordinator.viewController(forKey: .to) else {return}
            let fromStyle = fromVC.rnb_navigationBarStyleForTransition()
            let toStyle = toVC.rnb_navigationBarStyleForTransition()

            if self.updateInteractiveTransitionCoordinator == nil || self.updateInteractiveTransitionCoordinator !== coordinator {
                //这是第一次执行本方法
                rnblog("第一次执行updateInteractiveTransition")
                self.updateInteractiveTransitionCoordinator = coordinator

                coordinator.notifyWhenInteractionChanges {[weak self] (context) in
                    //当交互状态发生变化的时候, 表示用户在侧滑过程中抬起了手指, 需要根据context的状态判断是继续前进还是返回原VC
                    let vc:UIViewController
                    if context.isCancelled {
                        rnblog("侧滑中断 - 取消")
                        vc = fromVC
                    }else {
                        rnblog("侧滑中断 - 继续")
                        vc = toVC
                    }
                    UIView.animate(withDuration: coordinator.transitionDuration, animations: {
                        rnblog("侧滑中断 - 动画执行")
                        self?.rnb_applyNavigationBarStyle(style: vc.rnb_navigationBarStyleForTransition(), applyImmediatelly: true, animatedOnly: nil)
                    }) { (_) in
                        rnblog("侧滑中断动画结束")
                        self?.updateInteractiveTransitionCoordinator = nil
                        self?.rnb_applyNavigationBarStyle(style: vc.rnb_navigationBarStyleForTransition(), applyImmediatelly: false, animatedOnly: nil)
                    }
                }
            }
            self.rnb_applyNavigationBarStyleInteractively(fromStyle: fromStyle, toStyle: toStyle, progress: percentComplete)
        }
    }

    ///侧滑手势的action, 用于在debug的时候输出手势状态
    @objc internal func onInteractivePopGestureRecognizer(sender:AnyObject?) {
        guard RXCNavigationBarTransition.shouldWorkOnNavigationController(self) else {return}
        guard let gesture = sender as? UIGestureRecognizer else {return}
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
    }


}
