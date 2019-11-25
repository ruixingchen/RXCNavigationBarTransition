//
//  UIViewController+MethodExchange.swift
//  Example
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc func rnbsw_viewDidLoad() {
        //记录下当前viewDidLoad是否被调用
        self.rnb_viewDidLoad_called = true
        self.rnbsw_viewDidLoad()
    }

    @objc func rnbsw_viewWillAppear(_ animated: Bool) {
        self.rnb_visibility = .willAppear
        rnblog("viewWillAppear: \(self.title ?? "no title") @ \(self.description)")
        self.rnbsw_viewWillAppear(animated)
    }

    @objc func rnbsw_viewDidAppear(_ animated: Bool) {
        self.rnb_visibility = .didAppear
        self.rnb_viewDidAppear_called = true
        rnblog("viewDidAppear: \(self.title ?? "no title") @ \(self.description)")
        if let nav = self as? UINavigationController {
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
