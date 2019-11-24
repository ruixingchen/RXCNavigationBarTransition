//
//  UINavigationBar+Misc.swift
//  Example
//
//  Created by ruixingchen on 11/24/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {

    ///用于接收当前对象被deinit的对象
    internal class DeinitDetectObject {

        let closure:()->Void

        init(closure:@escaping ()->Void) {
            self.closure = closure
        }

        deinit {
            closure()
        }
    }

    internal class KeyValueOberver:NSObject {

        var observeValueClosure:(_ keyPath: String?, _ object: Any?, _ change: [NSKeyValueChangeKey : Any]?, _ context: UnsafeMutableRawPointer?)->Void

        init(observeValueClosure:@escaping (_ keyPath: String?, _ object: Any?, _ change: [NSKeyValueChangeKey : Any]?, _ context: UnsafeMutableRawPointer?)->Void) {
            self.observeValueClosure = observeValueClosure
            super.init()
        }

        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            self.observeValueClosure(keyPath, object, change, context)
        }

    }

}

//MARK: - 方法
extension UINavigationBar {

    //修复新添加的View的顺序
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

    ///重新布局本工具添加的一些工具View
    internal func rnb_layoutRNBSubviews() {
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
                //scale = 0.25
            }
            #endif
            self.rnb_shadowView1.frame = CGRect(x: 0, y: _bounds.origin.y+_bounds.height, width: _bounds.width, height: 1/scale)
        }
    }

    /*
     //已经使用observer来修复了
    ///修复backgroundAlpha有时候会设置失效的问题
    internal func fixBackgroundAlphaProblem() {
        if let alpha = self.rnb_backgroundAlphaSetted {
            self.rnb_barBackgroundView?.alpha = alpha
        }
    }
     */

}
