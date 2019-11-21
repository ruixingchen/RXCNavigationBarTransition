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
    }

    ///背景颜色View, 这里使用UIImageView是为了以后能支持背景图片
    internal var rnb_backgroundView:UIImageView {
        var view = objc_getAssociatedObject(self, &Key.rnb_backgroundView) as? UIImageView
        if view == nil {
            view = UIImageView()
            objc_setAssociatedObject(self, &Key.rnb_backgroundView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view!
    }

    internal func addBackgroundViewIfNeeded() {
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
    }

    @objc internal func rnbsw_layoutSubviews() {
        self.rnbsw_layoutSubviews()
        self.addBackgroundViewIfNeeded()
    }

}

extension UINavigationBar {

    internal func rnb_setAlpha(_ value: CGFloat) {
        self.alpha = value
    }

    internal func rnb_setBackgroundAlpha(_ value: CGFloat) {
        let view = self.rnb_barBackgroundView
        view?.alpha = value
    }

    internal func rnb_setBackgroundColor(_ value: UIColor) {
        self.addBackgroundViewIfNeeded()
        self.rnb_backgroundView.backgroundColor = value
    }

    internal func rnb_setTintColor(_ value: UIColor?) {
        self.tintColor = value
    }

    internal func rnb_setTitleColor(_ value: UIColor?) {
        var attributes = self.titleTextAttributes ?? [:]
        attributes[.backgroundColor] = value
        self.titleTextAttributes = attributes
    }

    internal func rnb_setShadowViewHidden(_ value: Bool) {
        let view = self.rnb_shadowView
        if value {
            view?.alpha = 0
        }else {
            view?.alpha = 1
        }
    }

}

extension UINavigationBar {

    internal func applyTintColorImmediatelly() {
        //let color = self.tintColor
        //self.rnb_stackButtons.forEach({$0.tintColor = color})
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
        style.backgroundAlphaSetting = .setted(self.rnb_barBackgroundView?.alpha ?? RXCNavigationBarTransition.defaultBackgroundAlpha)
        style.backgroundColorSetting = .setted(self.rnb_backgroundView.backgroundColor ?? UIColor.clear)
        style.tintColorSetting = .setted(self.tintColor)
        style.titleColorSetting = .setted(self.rnb_titleLabel?.textColor ?? RXCNavigationBarTransition.defaultTitleColor)
        style.shadowViewHiddenSetting = .setted(self.rnb_shadowView?.alpha ?? 1 == 0)
        style.statusBarStyleSetting = .setted(UIApplication.shared.statusBarStyle)
        return style
    }

}
