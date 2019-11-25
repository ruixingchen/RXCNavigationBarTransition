//
//  UIViewController+Style.swift
//  Example
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    //设置样式的时候
    //1, 如果这个VC是当前正在显示的VC, 那么直接修改样式
    //2, 如果这个VC是唯一的VC, 且这个VC尚未进入didAppear流程, 那么直接修改样式, 对应初始化时候的场景; 同时也解决了当Nav有两个VC, 进行pop的时候会首先将第二个VC移出栈, 导致第一个VC认为自己是唯一的VC而强制修改样式的问题
    //其他情况下则只记录不修改, 当这个VC被显示的时候会自动将保存的样式应用到navBar上

    ///当前是否可以更新NavBar的样式, 只有两种情况下可以立刻更新样式, 1: 正在显示, 2: Root页初始化
    internal func canUpdateNavigationBarStyle()->Bool {
        let initialPage = (self.rnb_isNavOnlyViewController() && !self.rnb_viewDidAppear_called)
        let visiblePage = (self.rnb_isNavTopViewController() && self.rnb_visibility == .didAppear)
        return initialPage || visiblePage
    }

    public internal(set) var rnb_navigationBarAlphaSetting:RNBSetting<CGFloat> {
        get {return self.rnb_navigationBarStyle.backgroundAlphaSetting}
        set {
            self.rnb_navigationBarStyle.alphaSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.alphaSetting = self.rnb_navigationBarStyle.alphaSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarAlpha(setting: self.rnb_navigationBarStyle.alphaSetting)
            }
        }
    }
    public func rnb_setNavigationBarAlpha(_ value:CGFloat) {
        self.rnb_navigationBarAlphaSetting = .setted(value)
    }
    public func rnb_clearNavigationBarAlphaSetting() {
        self.rnb_navigationBarAlphaSetting = .notset
    }

    public internal(set) var rnb_navigationBarBackgroundAlphaSetting:RNBSetting<CGFloat> {
        get {return self.rnb_navigationBarStyle.backgroundAlphaSetting}
        set {
            self.rnb_navigationBarStyle.backgroundAlphaSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.backgroundAlphaSetting = self.rnb_navigationBarStyle.backgroundAlphaSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarBackgroundAlpha(setting: self.rnb_navigationBarStyle.backgroundAlphaSetting)
            }
        }
    }
    public func rnb_setNavigationBarBackgroundAlpha(_ value:CGFloat) {
        self.rnb_navigationBarBackgroundAlphaSetting = .setted(value)
    }
    public func rnb_clearNavigationBarBackgroundAlphaSetting() {
        self.rnb_navigationBarBackgroundAlphaSetting = .notset
    }

    public internal(set) var rnb_navigationBarBackgroundColorSetting:RNBSetting<UIColor> {
        get {return self.rnb_navigationBarStyle.backgroundColorSetting}
        set {
            self.rnb_navigationBarStyle.backgroundColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.backgroundColorSetting = self.rnb_navigationBarStyle.backgroundColorSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarBackgroundColor(setting: self.rnb_navigationBarStyle.backgroundColorSetting)
            }
        }
    }
    public func rnb_setNavigationBarBackgroundColor(_ value:UIColor) {
        self.rnb_navigationBarBackgroundColorSetting = .setted(value)
    }
    public func rnb_clearNavigationBarBackgroundColorSetting() {
        self.rnb_navigationBarBackgroundColorSetting = .notset
    }

    public internal(set) var rnb_navigationBarForegroundColorSetting:RNBSetting<UIColor> {
        get {return self.rnb_navigationBarStyle.foregroundColorSetting}
        set {
            self.rnb_navigationBarStyle.foregroundColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.foregroundColorSetting = self.rnb_navigationBarStyle.foregroundColorSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarForegroundColor(setting: self.rnb_navigationBarStyle.foregroundColorSetting)
            }
        }
    }
    public func rnb_setNavigationBarForegroundColor(_ value:UIColor) {
        self.rnb_navigationBarForegroundColorSetting = .setted(value)
    }
    public func rnb_clearNavigationBarForegroundColorSetting() {
        self.rnb_navigationBarForegroundColorSetting = .notset
    }

    public internal(set) var rnb_navigationBarTintColorSetting: RNBSetting<UIColor> {
        get {return self.rnb_navigationBarStyle.tintColorSetting}
        set {
            self.rnb_navigationBarStyle.tintColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.tintColorSetting = self.rnb_navigationBarStyle.tintColorSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarTintColor(setting: self.rnb_navigationBarStyle.tintColorSetting)
            }
        }
    }
    public func rnb_setNavigationBarTintColor(_ value:UIColor) {
        self.rnb_navigationBarTintColorSetting = .setted(value)
    }
    public func rnb_clearNavigationBarTintColorSetting() {
        self.rnb_navigationBarTintColorSetting = .notset
    }

    public internal(set) var rnb_navigationBarTitleColorSetting:RNBSetting<UIColor> {
        get {return self.rnb_navigationBarStyle.titleColorSetting}
        set {
            self.rnb_navigationBarStyle.titleColorSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.titleColorSetting = self.rnb_navigationBarStyle.titleColorSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarTitleColor(setting: self.rnb_navigationBarStyle.titleColorSetting)
            }
        }
    }
    public func rnb_setNavigationBarTitleColor(_ value:UIColor) {
        self.rnb_navigationBarTitleColorSetting = .setted(value)
    }
    public func rnb_clearNavigationBarTitleColorSetting() {
        self.rnb_navigationBarTitleColorSetting = .notset
    }

    public internal(set) var rnb_navigationBarShadowViewHiddenSetting: RNBSetting<Bool> {
        get {return self.rnb_navigationBarStyle.shadowViewHiddenSetting}
        set {
            self.rnb_navigationBarStyle.shadowViewHiddenSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.shadowViewHiddenSetting = self.rnb_navigationBarStyle.shadowViewHiddenSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setNavigationBarShadowViewHidden(setting: self.rnb_navigationBarStyle.shadowViewHiddenSetting)
            }
        }

    }
    public func rnb_setNavigationBarShadowViewHidden(_ value:Bool) {
        self.rnb_navigationBarShadowViewHiddenSetting = .setted(value)
    }
    public func rnb_clearNavigationBarShadowViewHiddenSetting() {
        self.rnb_navigationBarShadowViewHiddenSetting = .notset
    }

    public internal(set) var rnb_statusBarStyleSetting: RNBSetting<UIStatusBarStyle> {
        get {return self.rnb_navigationBarStyle.statusBarStyleSetting}
        set {
            self.rnb_navigationBarStyle.statusBarStyleSetting = newValue
            self.rnb_navigationBarStyleSavedBeforeTransition?.statusBarStyleSetting = self.rnb_navigationBarStyle.statusBarStyleSetting
            if self.canUpdateNavigationBarStyle() {
                self.navigationController?.rnbnav_setStatusBarStyle()
            }
        }
    }
    public func rnb_setStatusBarStyle(_ value:UIStatusBarStyle) {
        self.rnb_statusBarStyleSetting = .setted(value)
    }
    public func rnb_clearStatusBarStyleSetting() {
        self.rnb_statusBarStyleSetting = .notset
    }

}
