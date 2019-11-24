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
        static var rnb_backgroundAlphaSetted:String = "rnb_backgroundAlphaSetted"
        static var rnb_deinitDetectObject:String = "rnb_deinitDetectObject"
        static var rnb_barBackgroundAlphaObserverContext:String = "rnb_barBackgroundAlphaObserverContext"
        static var rnb_keyValueObserver:String = "rnb_keyValueObserver"
    }

    //MARK: - backgroundAlpha

    internal var rnb_deinitDetectObject:DeinitDetectObject {
        var object = objc_getAssociatedObject(self, &Key.rnb_deinitDetectObject) as? DeinitDetectObject
        if object == nil {
            //一定要weak self
            object = DeinitDetectObject(closure: {[weak self] () in
                guard let sself = self, self?.rnb_barBackgroundAlphaObserverContext != nil else {return}
                if sself.rnb_barBackgroundAlphaObserverContext != nil {
                    self?.rnb_barBackgroundView?.removeObserver(sself, forKeyPath: #keyPath(UIView.alpha), context: &(sself.rnb_barBackgroundAlphaObserverContext!))
                }
            })
            objc_setAssociatedObject(self, &Key.rnb_deinitDetectObject, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return object!
    }

    internal var rnb_keyValueObserver: KeyValueOberver {
        var object = objc_getAssociatedObject(self, &Key.rnb_keyValueObserver) as? KeyValueOberver
        if object == nil {
            //一定要weak self
            object = KeyValueOberver(observeValueClosure: {[weak self] (keyPath, object, changes, context) in
                guard let sself = self else {return}
                if let view = object as? UIView, view == self?.rnb_barBackgroundView {
                    if keyPath == #keyPath(UIView.alpha), let newAlpha = changes?[.newKey] as? CGFloat, self?.rnb_barBackgroundAlphaObserverContext != nil && context == Unmanaged.passUnretained(sself.rnb_barBackgroundAlphaObserverContext!).toOpaque() {
                        if let fixedAlpha = sself.rnb_backgroundAlphaSetted, abs(newAlpha - fixedAlpha) > 0.000001 {
                            //这里由于设置alpha后, 获取到的newAlpha和原先设置的alpha是有差别的, 这里直接取一个范围, 当前取6位小数, 应该是足够了
                            rnblog("BarBackground的alpha被意外改变了: \(newAlpha), 要求的固定值: \(sself.rnb_backgroundAlphaSetted?.description ?? "nil")")
                            view.alpha = fixedAlpha
                        }
                    }
                }
            })
            objc_setAssociatedObject(self, &Key.rnb_keyValueObserver, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return object!
    }

    internal var rnb_barBackgroundAlphaObserverContext: NSObject? {
        get {
            let object = objc_getAssociatedObject(self, &Key.rnb_barBackgroundAlphaObserverContext) as? NSObject
            return object
        }
        set {
            objc_setAssociatedObject(self, &Key.rnb_barBackgroundAlphaObserverContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            #if (debug || DEBUG)
            if var object = newValue {
                let pointer = Unmanaged.passUnretained(object).toOpaque()
                rnblog("设置了barBackgroundAlphaObserverContext:\(pointer)")
            }
            #endif
        }
    }

    ///记录下外部设置的backgroundAlpha, 强制设置_BarBackgroundView的alpha为这个值, 解决NavBar可能会修改_BarBackgroundView的alpha的问题
    internal var rnb_backgroundAlphaSetted:CGFloat? {
        get {return objc_getAssociatedObject(self, &Key.rnb_backgroundAlphaSetted) as? CGFloat}
        set {objc_setAssociatedObject(self, &Key.rnb_backgroundAlphaSetted, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }

    //MARK: - other

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

}

