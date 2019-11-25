//
//  UIViewController+MethodSwitch.swift
//  Example
//
//  Created by ruixingchen on 2019/11/25.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc func ftv_loadView() {
        ftvlog("ftv_loadView")
        self.ftv_loadView()
        self.ftv_lifeCycle = .loadView
        for i in self.ftv_loadViewTasks {i.task()}
        self.ftv_loadViewTasks = self.ftv_loadViewTasks.filter({!$0.removedAfterExcuted})
    }

    @objc func ftv_viewDidLoad() {
        ftvlog("ftv_viewDidLoad")
        self.ftv_viewDidLoad()
        self.ftv_lifeCycle = .viewDidLoad

        for i in self.ftv_viewDidLoadTasks {i.task()}
        self.ftv_viewDidLoadTasks = self.ftv_viewDidLoadTasks.filter({!$0.removedAfterExcuted})
    }

    @objc func ftv_viewWillAppear(_ animated: Bool) {
        ftvlog("ftv_viewWillAppear")
        if !self.ftv_viewWillAppear_called {
            self.ftv_viewWillAppear_called = true
            self.ftv_viewWillAppear_first(animated)
        }

        self.ftv_viewWillAppear(animated)
        self.ftv_lifeCycle = .viewWillAppear
        self.ftv_visibility = .willAppear

        for i in self.ftv_viewWillAppearTasks {i.task()}
        self.ftv_viewWillAppearTasks = self.ftv_viewWillAppearTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 11.0, *)
    @objc open func ftv_viewLayoutMarginsDidChange() {
        ftvlog("ftv_viewLayoutMarginsDidChange")
        if !self.ftv_viewLayoutMarginsDidChange_called {
            self.ftv_viewLayoutMarginsDidChange_called = true
            self.ftv_viewLayoutMarginsDidChange_first()
        }

        self.ftv_viewLayoutMarginsDidChange()
        self.ftv_lifeCycle = .viewLayoutMarginsDidChange

        for i in self.ftv_viewLayoutMarginsDidChangeTasks {i.task()}
        self.ftv_viewLayoutMarginsDidChangeTasks = self.ftv_viewLayoutMarginsDidChangeTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 11.0, *)
    @objc func ftv_viewSafeAreaInsetsDidChange() {
        ftvlog("ftv_viewSafeAreaInsetsDidChange")
        if !self.ftv_viewSafeAreaInsetsDidChange_called {
            self.ftv_viewSafeAreaInsetsDidChange_called = true
            self.ftv_viewSafeAreaInsetsDidChange_first()
        }

        self.ftv_viewSafeAreaInsetsDidChange()
        self.ftv_lifeCycle = .viewSafeAreaInsetsDidChange

        for i in self.ftv_viewSafeAreaInsetsDidChangeTasks {i.task()}
        self.ftv_viewSafeAreaInsetsDidChangeTasks = self.ftv_viewSafeAreaInsetsDidChangeTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 6.0, *)
    @objc func ftv_updateViewConstraints() {
        ftvlog("ftv_updateViewConstraints")
        if !self.ftv_updateViewConstraints_called {
            self.ftv_updateViewConstraints_called = true
            self.ftv_updateViewConstraints_first()
        }

        self.ftv_updateViewConstraints()
        self.ftv_lifeCycle = .updateViewConstraints

        for i in self.ftv_updateViewConstraintsTasks {i.task()}
        self.ftv_updateViewConstraintsTasks = self.ftv_updateViewConstraintsTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 5.0, *)
    @objc func ftv_viewWillLayoutSubviews() {
        ftvlog("ftv_viewWillLayoutSubviews")
        if !self.ftv_viewWillLayoutSubviews_called {
            self.ftv_viewWillLayoutSubviews_called = true
            self.ftv_viewWillLayoutSubviews_first()
        }

        self.ftv_viewWillLayoutSubviews()
        self.ftv_lifeCycle = .viewWillLayoutSubviews

        for i in self.ftv_viewWillLayoutSubviewsTasks {i.task()}
        self.ftv_viewWillLayoutSubviewsTasks = self.ftv_viewWillLayoutSubviewsTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 5.0, *)
    @objc func ftv_viewDidLayoutSubviews() {
        ftvlog("ftv_viewDidLayoutSubviews")
        if !self.ftv_viewDidLayoutSubviews_called {
            self.ftv_viewDidLayoutSubviews_called = true
            self.ftv_viewDidLayoutSubviews_first()
        }

        self.ftv_viewDidLayoutSubviews()
        self.ftv_lifeCycle = .viewDidLayoutSubviews

        for i in self.ftv_viewDidLayoutSubviewsTasks {i.task()}
        self.ftv_viewDidLayoutSubviewsTasks = self.ftv_viewDidLayoutSubviewsTasks.filter({!$0.removedAfterExcuted})
    }

    @objc func ftv_viewDidAppear(_ animated: Bool) {
        ftvlog("ftv_viewDidAppear")
        if !self.ftv_viewDidAppear_called {
            self.ftv_viewDidAppear_called = true
            self.ftv_viewDidAppear_first(animated)
        }

        self.ftv_viewDidAppear(animated)
        self.ftv_lifeCycle = .viewDidAppear
        self.ftv_visibility = .didAppear

        for i in self.ftv_viewDidAppearTasks {i.task()}
        self.ftv_viewDidAppearTasks = self.ftv_viewDidAppearTasks.filter({!$0.removedAfterExcuted})
    }

    @objc func ftv_viewWillDisappear(_ animated: Bool) {
        ftvlog("ftv_viewWillDisappear")
        if !self.ftv_viewWillDisappear_called {
            self.ftv_viewWillDisappear_called = true
            self.ftv_viewWillDisappear_first(animated)
        }

        self.ftv_viewWillDisappear(animated)
        self.ftv_lifeCycle = .viewWillDisappear
        self.ftv_visibility = .willDisappear

        for i in self.ftv_viewWillDisappearTasks {i.task()}
        self.ftv_viewWillDisappearTasks = self.ftv_viewWillDisappearTasks.filter({!$0.removedAfterExcuted})
    }

    @objc func ftv_viewDidDisappear(_ animated: Bool) {
        ftvlog("ftv_viewDidDisappear")
        if !self.ftv_viewDidDisappear_called {
            self.ftv_viewDidDisappear_called = true
            self.ftv_viewDidDisappear_first(animated)
        }

        self.ftv_viewDidDisappear(animated)
        self.ftv_lifeCycle = .viewDidDisappear
        self.ftv_visibility = .didDisappear

        for i in self.ftv_viewDidDisappearTasks {i.task()}
        self.ftv_viewDidDisappearTasks = self.ftv_viewDidDisappearTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 5.0, *)
    @objc func ftv_willMove(toParent parent: UIViewController?) {
        ftvlog("ftv_willMove")
        if !self.ftv_willMove_called {
            self.ftv_willMove_called = true
            self.ftv_willMove_first(toParent: parent)
        }

        self.ftv_willMove(toParent: parent)

        for i in self.ftv_willMoveTasks {i.task()}
        self.ftv_willMoveTasks = self.ftv_willMoveTasks.filter({!$0.removedAfterExcuted})
    }

    @available(iOS 5.0, *)
    @objc func ftv_didMove(toParent parent: UIViewController?) {
        ftvlog("ftv_didMove")
        if !self.ftv_didMove_called {
            self.ftv_didMove_called = true
            self.ftv_didMove_first(toParent: parent)
        }

        self.ftv_didMove(toParent: parent)

        for i in self.ftv_didMoveTasks {i.task()}
        self.ftv_didMoveTasks = self.ftv_didMoveTasks.filter({!$0.removedAfterExcuted})
    }

}
