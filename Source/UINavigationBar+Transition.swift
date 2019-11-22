//
//  UINavigationBar+Transition.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {

    internal struct Key {
        static var rnb_backgroundView:String = "rnb_backgroundView"
        static var rnb_foregroundView:String = "rnb_foregroundView"
    }

    ///背景颜色View, 这里使用UIImageView是为了以后能支持背景图片
    internal var rnb_backgroundView:UIImageView {
        var view = objc_getAssociatedObject(self, &Key.rnb_backgroundView) as? UIImageView
        if view == nil {
            view = UIImageView()
            //强制显示在最深
            view?.layer.zPosition = CGFloat(-Float.greatestFiniteMagnitude)
            objc_setAssociatedObject(self, &Key.rnb_backgroundView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view!
    }

    ///前景颜色View
    internal var rnb_foregroundView:UIImageView {
        var view = objc_getAssociatedObject(self, &Key.rnb_foregroundView) as? UIImageView
        if view == nil {
            view = UIImageView()
            //强制显示在最浅
            view?.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
            objc_setAssociatedObject(self, &Key.rnb_foregroundView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view!
    }

    internal func addBackgroundAndForegroundViewIfNeeded() {
        if self.rnb_backgroundView.superview == nil {
            self.rnb_barBackgroundView?.insertSubview(self.rnb_backgroundView, at: 0)
        }else if self.rnb_barBackgroundView?.subviews.first != self.rnb_backgroundView {
            #if (debug || DEBUG)
            rnblog("背景色View的index被改变了: \(self.rnb_barBackgroundView?.subviews.map({$0.description}).joined(separator: "///") ?? "no subviews")")
            #endif
            //self.rnb_barBackgroundView?.bringSubviewToFront(self.rnb_backgroundView)
            self.rnb_barBackgroundView?.sendSubviewToBack(self.rnb_backgroundView)
        }
        if self.rnb_backgroundView.frame != self.rnb_barBackgroundView?.bounds {
            self.rnb_backgroundView.frame = self.rnb_barBackgroundView?.bounds ?? self.rnb_backgroundView.frame
        }

        if self.rnb_foregroundView.superview == nil {
            self.rnb_barBackgroundView?.addSubview(self.rnb_foregroundView)
        }else if self.rnb_barBackgroundView?.subviews.last != self.rnb_foregroundView {
            #if (debug || DEBUG)
            rnblog("前景色View的index被改变了: \(self.rnb_barBackgroundView?.subviews.map({$0.description}).joined(separator: "///") ?? "no subviews")")
            #endif
            self.rnb_barBackgroundView?.bringSubviewToFront(self.rnb_foregroundView)
        }
        if self.rnb_foregroundView.frame != self.rnb_barBackgroundView?.bounds {
            self.rnb_foregroundView.frame = self.rnb_barBackgroundView?.bounds ?? self.rnb_foregroundView.frame
        }
    }

    @objc func rnbsw_layoutSubviews() {
        self.rnbsw_layoutSubviews()
        self.addBackgroundAndForegroundViewIfNeeded()
    }

    @objc func rnbsw_addSubview(_ view: UIView) {
        self.rnbsw_addSubview(view)
        self.addBackgroundAndForegroundViewIfNeeded()
    }

    @objc func rnbsw_willRemoveSubview(_ subview: UIView) {
        self.rnbsw_willRemoveSubview(subview)
        self.addBackgroundAndForegroundViewIfNeeded()
    }

    @objc func rnbsw_willMove(toSuperview newSuperview: UIView?) {
        self.rnbsw_willMove(toSuperview: newSuperview)
        self.addBackgroundAndForegroundViewIfNeeded()
    }

}

extension UINavigationBar {

    internal func rnb_setAlpha(_ value: CGFloat) {
        self.alpha = value
    }

    internal func rnb_setBackgroundAlpha(_ value: CGFloat) {
        let view = self.rnb_barBackgroundView
        if RNBHelper.isOperatingSystemAtLeast(11, 0, 0) {
            view?.subviews.forEach({$0.alpha = value})
        }else {
            view?.alpha = value
        }
    }

    internal func rnb_setBackgroundColor(_ value: UIColor) {
        self.addBackgroundAndForegroundViewIfNeeded()
        self.rnb_backgroundView.backgroundColor = value
    }

    internal func rnb_setForegroundColor(_ value: UIColor) {
        self.addBackgroundAndForegroundViewIfNeeded()
        self.rnb_foregroundView.backgroundColor = value
    }

    internal func rnb_setTintColor(_ value: UIColor?) {
        self.tintColor = value
    }

    internal func rnb_setTitleColor(_ value: UIColor?) {
        var attributes = self.titleTextAttributes ?? [:]
        attributes[.foregroundColor] = value
        self.titleTextAttributes = attributes
    }

    internal func rnb_setShadowViewHidden(_ value: Bool) {
        let view = self.rnb_shadowView
        if RNBHelper.isOperatingSystemAtLeast(13, 0, 0) {
            if value {
                view?.alpha = 0
            }else {
                view?.alpha = 1
            }
        }else {
            view?.isHidden = value
        }
    }

}

extension UINavigationBar {

    internal func applyTintColorImmediatelly() {
        let color = self.tintColor
        self.rnb_stackButtons.forEach({$0.tintColor = color})
    }

    internal func applyTitleColorImmediatelly() {
        if let attributes = self.titleTextAttributes, let att = self.rnb_titleLabel?.attributedText {
            let matt = NSMutableAttributedString(attributedString: att)
            matt.addAttributes(attributes, range: NSRange(location: 0, length: matt.length))
            self.rnb_titleLabel?.attributedText = matt
        }
    }

}

extension UINavigationBar {

    ///按照当前导航栏的样式生成style对象
    internal func rnb_currentStyle()->RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(self.alpha)
        if RNBHelper.isOperatingSystemAtLeast(11, 0, 0) {
            style.backgroundAlphaSetting = .setted(self.rnb_barBackgroundView?.subviews.first?.alpha ?? RXCNavigationBarTransition.defaultBackgroundAlpha)
        }else {
            style.backgroundAlphaSetting = .setted(self.rnb_barBackgroundView?.alpha ?? RXCNavigationBarTransition.defaultBackgroundAlpha)
        }

        style.backgroundColorSetting = .setted(self.rnb_backgroundView.backgroundColor ?? UIColor.clear)
        style.foregroundColorSetting = .setted(self.rnb_foregroundView.backgroundColor ?? UIColor.clear)
        style.tintColorSetting = .setted(self.tintColor)
        style.titleColorSetting = .setted(self.rnb_titleLabel?.textColor ?? RXCNavigationBarTransition.defaultTitleColor)
        if RNBHelper.isOperatingSystemAtLeast(13, 0, 0) {
            style.shadowViewHiddenSetting = .setted(self.rnb_shadowView?.alpha ?? 1 == 0)
        }else {
            style.shadowViewHiddenSetting = .setted(self.rnb_shadowView?.isHidden ?? true)
        }
        style.statusBarStyleSetting = .setted(UIApplication.shared.statusBarStyle)
        return style
    }

}
