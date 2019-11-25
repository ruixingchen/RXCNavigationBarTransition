//
//  UIViewController+MethodCalled.swift
//  RXCFirstTimeViewController
//
//  Created by ruixingchen on 2019/11/24.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    public enum FTVVisibility:Int {
        case none = 0
        case didDisappear
        case willDisappear
        case willAppear
        case didAppear
    }

    public enum FTVLifeCycle: Int {
        ///just inited
        case none = 0
        case loadView
        case viewDidLoad
        case viewWillAppear
        @available(iOS 11, *)
        case viewLayoutMarginsDidChange
        @available(iOS 11, *)
        case viewSafeAreaInsetsDidChange
        @available(iOS 6, *)
        case updateViewConstraints
        case viewWillLayoutSubviews
        case viewDidLayoutSubviews
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
    }

}

extension UIViewController {

    internal struct Key {
        static var ftv_lifeCycle = "ftv_lifeCycle"
        static var ftv_visibility = "ftv_visibility"

        static var ftv_viewWillAppear_called = "ftv_viewWillAppear_called"
        static var ftv_viewLayoutMarginsDidChange_called = "ftv_viewLayoutMarginsDidChange_called"
        static var ftv_viewSafeAreaInsetsDidChange_called = "ftv_viewSafeAreaInsetsDidChange_called"
        static var ftv_updateViewConstraints_called = "ftv_updateViewConstraints_called"
        static var ftv_viewWillLayoutSubviews_called = "ftv_viewWillLayoutSubviews_called"
        static var ftv_viewDidLayoutSubviews_called = "ftv_viewDidLayoutSubviews_called"
        static var ftv_viewDidAppear_called = "ftv_viewDidAppear_called"
        static var ftv_viewWillDisappear_called = "ftv_viewWillDisappear_called"
        static var ftv_viewDidDisappear_called = "ftv_viewDidDisappear_called"

        static var ftv_willMove_called = "ftv_willMove_called"
        static var ftv_didMove_called = "ftv_didMove_called"
    }

    public internal(set) var ftv_lifeCycle:FTVLifeCycle {
        get {return objc_getAssociatedObject(self, &Key.ftv_lifeCycle) as? FTVLifeCycle ?? .none}
        set {objc_setAssociatedObject(self, &Key.ftv_lifeCycle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_visibility:FTVVisibility {
        get {return objc_getAssociatedObject(self, &Key.ftv_visibility) as? FTVVisibility ?? .none}
        set {objc_setAssociatedObject(self, &Key.ftv_visibility, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    //MARK: - Called

    public internal(set) var ftv_viewWillAppear_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillAppear_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillAppear_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewLayoutMarginsDidChange_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewLayoutMarginsDidChange_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewLayoutMarginsDidChange_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewSafeAreaInsetsDidChange_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewSafeAreaInsetsDidChange_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewSafeAreaInsetsDidChange_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_updateViewConstraints_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_updateViewConstraints_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_updateViewConstraints_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewWillLayoutSubviews_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillLayoutSubviews_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillLayoutSubviews_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewDidLayoutSubviews_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidLayoutSubviews_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidLayoutSubviews_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewDidAppear_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidAppear_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidAppear_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewWillDisappear_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillDisappear_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillDisappear_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_viewDidDisappear_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidDisappear_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidDisappear_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_willMove_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_willMove_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_willMove_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public internal(set) var ftv_didMove_called:Bool {
        get {return objc_getAssociatedObject(self, &Key.ftv_didMove_called) as? Bool ?? false}
        set {objc_setAssociatedObject(self, &Key.ftv_didMove_called, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

}
