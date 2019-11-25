//
//  UIVIewController+LifeCycleTask.swift
//  Example
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    public class FTVLifeCycleTask {

        public var removedAfterExcuted:Bool

        internal var task:()->Void

        public init(removedAfterExcuted:Bool=true, task: @escaping ()->Void) {
            self.task = task
            self.removedAfterExcuted = removedAfterExcuted
        }
    }

}

internal extension UIViewController.Key {

    static var ftv_loadViewTasks = "ftv_loadViewTasks"
    static var ftv_viewDidLoadTasks = "ftv_viewDidLoadTasks"
    static var ftv_viewWillAppearTasks = "ftv_viewWillAppearTasks"
    static var ftv_viewLayoutMarginsDidChangeTasks = "ftv_viewLayoutMarginsDidChangeTasks"
    static var ftv_viewSafeAreaInsetsDidChangeTasks = "ftv_viewSafeAreaInsetsDidChangeTasks"
    static var ftv_updateViewConstraintsTasks = "ftv_updateViewConstraintsTasks"
    static var ftv_viewWillLayoutSubviewsTasks = "ftv_viewWillLayoutSubviewsTasks"
    static var ftv_viewDidLayoutSubviewsTasks = "ftv_viewDidLayoutSubviewsTasks"
    static var ftv_viewDidAppearTasks = "ftv_viewDidAppearTasks"
    static var ftv_viewWillDisappearTasks = "ftv_viewWillDisappearTasks"
    static var ftv_viewDidDisappearTasks = "ftv_viewDidDisappearTasks"

    static var ftv_willMoveTasks = "ftv_willMoveTasks"
    static var ftv_didMoveTasks = "ftv_didMoveTasks"

}

extension UIViewController {

    public var ftv_loadViewTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_loadViewTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_loadViewTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewDidLoadTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidLoadTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidLoadTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewWillAppearTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillAppearTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillAppearTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewLayoutMarginsDidChangeTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewLayoutMarginsDidChangeTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewLayoutMarginsDidChangeTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewSafeAreaInsetsDidChangeTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewSafeAreaInsetsDidChangeTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewSafeAreaInsetsDidChangeTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_updateViewConstraintsTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_updateViewConstraintsTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_updateViewConstraintsTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewWillLayoutSubviewsTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillLayoutSubviewsTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillLayoutSubviewsTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewDidLayoutSubviewsTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidLayoutSubviewsTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidLayoutSubviewsTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewDidAppearTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidAppearTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidAppearTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewWillDisappearTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewWillDisappearTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewWillDisappearTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_viewDidDisappearTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_viewDidDisappearTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_viewDidDisappearTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_willMoveTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_willMoveTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_willMoveTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    public var ftv_didMoveTasks:[FTVLifeCycleTask] {
        get {return objc_getAssociatedObject(self, &Key.ftv_didMoveTasks) as? [FTVLifeCycleTask] ?? []}
        set {objc_setAssociatedObject(self, &Key.ftv_didMoveTasks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

}

extension UIViewController {

    @discardableResult
    open func addLoadViewTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_loadViewTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewDidLoadTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewDidLoadTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewWillAppearTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewWillAppearTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewLayoutMarginsDidChangeTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewLayoutMarginsDidChangeTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewSafeAreaInsetsDidChangeTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewSafeAreaInsetsDidChangeTasks.append(task)
        return task
    }

    @discardableResult
    open func addUpdateViewConstraintsTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_updateViewConstraintsTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewWillLayoutSubviewsTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewWillLayoutSubviewsTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewDidLayoutSubviewsTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewDidLayoutSubviewsTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewDidAppearTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewDidAppearTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewWillDisappearTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewWillDisappearTasks.append(task)
        return task
    }

    @discardableResult
    open func addViewDidDisappearTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_viewDidDisappearTasks.append(task)
        return task
    }

    @discardableResult
    open func addWillMoveTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_willMoveTasks.append(task)
        return task
    }

    @discardableResult
    open func addDidMoveTask(removeAfterExcuted:Bool, task:@escaping ()->Void)->FTVLifeCycleTask {
        let task = FTVLifeCycleTask(removedAfterExcuted: removeAfterExcuted, task: task)
        self.ftv_didMoveTasks.append(task)
        return task
    }

}
