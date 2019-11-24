//
//  UINavigationBar+MethodSwitch.swift
//  Example
//
//  Created by ruixingchen on 11/24/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

//MARK: - 交换方法
extension UINavigationBar {

    @objc func rnbsw_layoutSubviews() {
        self.rnbsw_layoutSubviews()
        self.rnb_rearrangeSubviews()
        self.rnb_layoutRNBSubviews()

        //调用来确保deinitDetectObject被初始化
        let _ = self.rnb_deinitDetectObject

        //当第一次调用的时候, 为barbackgroundView添加observer
        if let view = self.rnb_barBackgroundView {
            if self.rnb_barBackgroundAlphaObserverContext == nil {
                self.rnb_barBackgroundAlphaObserverContext = NSObject()
                view.addObserver(self.rnb_keyValueObserver, forKeyPath: #keyPath(UIView.alpha), options: .new, context: Unmanaged.passUnretained(self.rnb_barBackgroundAlphaObserverContext!).toOpaque())
            }
        }
    }

    ///只在iOS13上会被调用
    @objc func rnbsw_addSubview(_ view: UIView) {
        self.rnbsw_addSubview(view)
        self.rnb_rearrangeSubviews()
    }

    ///只在iOS13上会被调用
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
