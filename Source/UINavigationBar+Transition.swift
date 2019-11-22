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
        static var rnbsw_shadowImage:String = "rnbsw_shadowImage"
        static var rnb_shadowView1:String = "rnb_shadowView1"
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

    ///自定义的底部阴影View, 在iOS13上, 这个View是一个visualEffectView, 在之前是一个UIImageView, 为了方便处理, 这里统一使用UIImageView
    internal var rnb_shadowView1: UIView {
        var view = objc_getAssociatedObject(self, &Key.rnb_shadowView1) as? UIView
        if view == nil {
            view = UIView()
            view?.isOpaque = false
            view?.alpha = 1
            if #available(iOS 13, *) {
                view?.backgroundColor = UIColor(dynamicProvider: { (trait) -> UIColor in
                    switch trait.userInterfaceStyle {
                    case .dark:
                        return UIColor.init(white: 1, alpha: 0.15)
                    case .light, .unspecified:
                        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                    @unknown default:
                        fatalError("Should Handle New Cases")
                    }
                })
            }else {
                view?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            }
            //强制显示在最浅
            //view?.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
            objc_setAssociatedObject(self, &Key.rnb_shadowView1, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view!
    }

    internal func rnb_rearrangeSubviews() {
        if self.rnb_backgroundView.superview == nil {
            self.rnb_barBackgroundView?.insertSubview(self.rnb_backgroundView, at: 0)
        }else if self.rnb_barBackgroundView?.subviews.first != self.rnb_backgroundView {
            self.rnb_barBackgroundView?.sendSubviewToBack(self.rnb_backgroundView)
        }

        if self.rnb_foregroundView.superview == nil {
            self.rnb_barBackgroundView?.addSubview(self.rnb_foregroundView)
        }else if self.rnb_barBackgroundView?.subviews.last != self.rnb_foregroundView {
            self.rnb_barBackgroundView?.bringSubviewToFront(self.rnb_foregroundView)
        }

        if self.rnb_shadowView1.superview == nil {
            self.rnb_barBackgroundView?.addSubview(self.rnb_shadowView1)
        }else if self.rnb_barBackgroundView?.subviews.last != self.rnb_shadowView1 {
            self.rnb_barBackgroundView?.bringSubviewToFront(self.rnb_shadowView1)
        }
    }

}

//MARK: - 交换方法
extension UINavigationBar {

    @objc func rnbsw_layoutSubviews() {
        self.rnbsw_layoutSubviews()
        self.rnb_rearrangeSubviews()
        if let _bounds = self.rnb_barBackgroundView?.bounds {
            self.rnb_backgroundView.frame = _bounds
            self.rnb_foregroundView.frame = _bounds
            var scale:CGFloat
            if #available(iOS 13, *) {
                scale = self.traitCollection.displayScale
            }else {
                scale = UIScreen.main.scale
            }
            #if (debug || DEBUG)
            //让高度更明显, 便于判断
            if RXCNavigationBarTransition.debugMode {
                scale = 0.25
            }
            #endif
            self.rnb_shadowView1.frame = CGRect(x: 0, y: _bounds.origin.y+_bounds.height, width: _bounds.width, height: 1/scale)
        }
    }

    @objc func rnbsw_addSubview(_ view: UIView) {
        self.rnbsw_addSubview(view)
        self.rnb_rearrangeSubviews()
    }

    @objc func rnbsw_willRemoveSubview(_ subview: UIView) {
        self.rnbsw_willRemoveSubview(subview)
        self.rnb_rearrangeSubviews()
    }

    ///强制返回一个空图片, 让系统自带的shadowView不显示
    @objc func rnbsw_shadowImage()->UIImage? {
        var image = objc_getAssociatedObject(self, &Key.rnbsw_shadowImage) as? UIImage
        if image == nil {
            image = UIImage()
            objc_setAssociatedObject(self, &Key.rnbsw_shadowImage, image, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return image
    }

}

extension UINavigationBar {

    internal func rnb_setAlpha(_ value: CGFloat) {
        self.alpha = value
    }

    internal func rnb_setBackgroundAlpha(_ value: CGFloat) {
        guard let view = self.rnb_barBackgroundView else {return}
        if RNBHelper.isOperatingSystemAtLeast(11, 0, 0) {
            for i in view.subviews {
                if i == self.rnb_shadowView1 {
                    return
                }
                i.alpha = value
            }
        }else {
            view.alpha = value
        }
    }

    internal func rnb_setBackgroundColor(_ value: UIColor) {
        self.rnb_rearrangeSubviews()
        self.rnb_backgroundView.backgroundColor = value
    }

    internal func rnb_setForegroundColor(_ value: UIColor) {
        self.rnb_rearrangeSubviews()
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
        //我们希望能够以渐变的形式来显示和隐藏底部的阴影view
        self.rnb_shadowView1.alpha = value ? 0 : 1
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

    internal func applyShadowHiddenImmediately() {
        //nothing
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
        style.shadowViewHiddenSetting = .setted(self.rnb_shadowView1.alpha == 0)
        if #available(iOS 13, *) {
            style.statusBarStyleSetting = .setted(UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarStyle ?? .default)
        }else {
            style.statusBarStyleSetting = .setted(UIApplication.shared.statusBarStyle)
        }
        return style
    }

}
