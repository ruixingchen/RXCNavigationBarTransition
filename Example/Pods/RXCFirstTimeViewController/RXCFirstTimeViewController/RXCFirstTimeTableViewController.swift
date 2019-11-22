//
//  RXCFirstTimeTableViewController.swift
//  RXCFirstTimeViewController
//
//  Created by ruixingchen on 2019/10/31.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

open class RXCFirstTimeTableViewController: UITableViewController {

    /// is this view during rotation transition?
    open var rxc_isRotating: Bool = false
    open var rxc_viewState:RFTViewState = .none
    open var rxc_layouting:Bool = false

    open var rxc_viewDidLoadTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_willAppearTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_willLayoutSubviewsTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_didLayoutSubviewsTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_didAppearTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_willDisappearTasks:[RXCViewControllerLifeCycleTask] = []
    open var rxc_didDisappearTasks:[RXCViewControllerLifeCycleTask] = []

    open var rxc_viewDidLoad_called:Bool = false
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.rxc_viewState = .viewDidLoad
        if !self.rxc_viewDidLoad_called {
            self.rxc_viewDidLoad_called = true
            self.rxc_viewDidLoad_first()
        }
        self.checkViewDidLoadTasks()
    }

    open func rxc_viewDidLoad_first() {

    }

    open func checkViewDidLoadTasks() {
        self.rxc_viewDidLoadTasks.forEach({$0.closure()})
        self.rxc_viewDidLoadTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open var rxc_viewWillAppear_called:Bool = false
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rxc_viewState = .willAppear
        if !self.rxc_viewWillAppear_called {
            self.rxc_viewWillAppear_called = true
            self.rxc_viewWillAppear_first(animated)
        }
        self.checkWillAppearTasks()
    }

    open func rxc_viewWillAppear_first(_ animated: Bool) {

    }

    open func checkWillAppearTasks() {
        self.rxc_willAppearTasks.forEach({$0.closure()})
        self.rxc_willAppearTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open var rxc_viewWillLayoutSubviews_called:Bool = false
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rxc_layouting = true
        if !self.rxc_viewWillLayoutSubviews_called {
            self.rxc_viewWillLayoutSubviews_called = true
            self.rxc_viewWillLayoutSubviews_first()
        }
        if self.rxc_isRotating {
            self.rxc_viewWillLayoutSubviewsInTransition()
        }
        self.checkWillLayoutSubviewsTasks()
    }

    open func rxc_viewWillLayoutSubviews_first() {

    }

    open func rxc_viewWillLayoutSubviewsInTransition(){

    }

    open func checkWillLayoutSubviewsTasks() {
        self.rxc_willLayoutSubviewsTasks.forEach({$0.closure()})
        self.rxc_willLayoutSubviewsTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open var rxc_viewDidLayoutSubviews_called:Bool = false
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.rxc_layouting = false
        if !self.rxc_viewDidLayoutSubviews_called {
            self.rxc_viewDidLayoutSubviews_called = true
            self.rxc_viewDidLayoutSubviews_first()
        }
        if self.rxc_isRotating {
            self.rxc_viewDidLayoutSubviewsInTransition()
        }
        self.checkDidLayoutSubviewsTasks()
    }

    open func rxc_viewDidLayoutSubviews_first(){

    }

    open func rxc_viewDidLayoutSubviewsInTransition(){

    }

    open func checkDidLayoutSubviewsTasks() {
        self.rxc_didLayoutSubviewsTasks.forEach({$0.closure()})
        self.rxc_didLayoutSubviewsTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    @available(iOS 11, *)
    open lazy var rxc_viewLayoutMarginsDidChange_called:Bool = false
    @available(iOS 11, *)
    open override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        if !self.rxc_viewLayoutMarginsDidChange_called {
            self.rxc_viewLayoutMarginsDidChange_called = true
            self.rxc_viewLayoutMarginsDidChange_first()
        }
    }

    @available(iOS 11, *)
    open func rxc_viewLayoutMarginsDidChange_first(){

    }

    @available(iOS 11, *)
    open lazy var rxc_viewSafeAreaInsetsDidChange_called:Bool = false
    @available(iOS 11, *)
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        if !self.rxc_viewSafeAreaInsetsDidChange_called {
            self.rxc_viewSafeAreaInsetsDidChange_called = true
            self.rxc_viewSafeAreaInsetsDidChange_first()
        }
    }

    @available(iOS 11, *)
    open func rxc_viewSafeAreaInsetsDidChange_first() {

    }

    open var rxc_viewDidAppear_called:Bool = false
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.rxc_viewState = .didAppear
        if !self.rxc_viewDidAppear_called {
            self.rxc_viewDidAppear_called = true
            self.rxc_viewDidAppear_first(animated)
        }
        self.checkDidAppearTasks()
    }

    open func rxc_viewDidAppear_first(_ animated: Bool) {

    }

    open func checkDidAppearTasks() {
        self.rxc_didAppearTasks.forEach({$0.closure()})
        self.rxc_didAppearTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open var rxc_viewWillDisappear_called:Bool = false
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rxc_viewState = .willDisappear
        if !self.rxc_viewWillDisappear_called {
            self.rxc_viewWillDisappear_called = true
            self.rxc_viewWillDisappear_first(animated)
        }
        self.checkWillDisappearTasks()
    }

    open func rxc_viewWillDisappear_first(_ animated: Bool) {

    }

    open func checkWillDisappearTasks() {
        self.rxc_willDisappearTasks.forEach({$0.closure()})
        self.rxc_willDisappearTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open var rxc_viewDidDisappear_called:Bool = false
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.rxc_viewState = .Disappear
        if !self.rxc_viewDidDisappear_called {
            self.rxc_viewDidDisappear_called = true
            self.rxc_viewDidDisappear_first(animated)
        }
        self.checkDidDisappearTasks()
    }

    open func rxc_viewDidDisappear_first(_ animated: Bool) {

    }

    open func checkDidDisappearTasks() {
        self.rxc_didDisappearTasks.forEach({$0.closure()})
        self.rxc_didDisappearTasks.removeAll(where: {$0.removeAfterExecuted})
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.rxc_isRotating = true
        coordinator.animateAlongsideTransition(in: nil, animation: nil) {[weak self] (_) in
            self?.rxc_isRotating = false
        }
    }

    open override func updateViewConstraints() {
        super.updateViewConstraints()
        self.rxc_initViewConstraintsIfNeeded()
    }

    open var rxc_viewConstraintsInited:Bool = false
    open func rxc_initViewConstraintsIfNeeded() {
        if !self.rxc_viewConstraintsInited {
            self.rxc_viewConstraintsInited = true
            self.rxc_initViewConstraints()
        }
    }

    open func rxc_initViewConstraints() {

    }

}
