//
//  UINavigationBar+Views.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /*
    ///获取底部的分割线
    public var rnb_shadowView:UIView? {
        guard let backgroundView = self.rnb_barBackgroundView else {
            return nil
        }
        let classs:AnyClass
        if #available(iOS 13, *) {
            guard let c = NSClassFromString("_UIBarBackgroundShadowView") else {
                assertionFailure("iOS13下无法生成_UIBarBackgroundShadowView类")
                return nil
            }
            classs = c
        }else {
            classs = UIImageView.self
        }

        let view = backgroundView.subviews.first { (i) -> Bool in
            let _frame = i.frame
            return i.isMember(of: classs) && _frame.origin.x == 0 && _frame.origin.y == backgroundView.bounds.height && _frame.width == backgroundView.bounds.width && _frame.height <= 1
        }
        #if (debug || DEBUG)
        if view == nil {
            backgroundView.subviews.forEach({print($0)})
            assertionFailure("无法获取NavBar底部分割线")
        }
        #endif

        return view
    }
     */

    public var rnb_barBackgroundView:UIView? {
        guard let classs = NSClassFromString("_UIBarBackground") else {
            assertionFailure("无法获取到 _UIBarBackground 类")
            return nil
        }
        guard let view = self.subviews.first(where: {$0.isMember(of: classs)}) else {
            //assertionFailure("无法获取到subviews中是 _UIBarBackground 的view")
            return nil
        }
        return view
    }

    public var rnb_barContentView:UIView? {
        //UINavigationItemView
        let classs:AnyClass
        if RNBHelper.isOperatingSystemAtLeast(11, 0, 0) {
            guard let _classs = NSClassFromString("_UINavigationBarContentView") else {
                assertionFailure("无法获取到 _UINavigationBarContentView 类")
                return nil
            }
            classs = _classs
        }else if RNBHelper.isOperatingSystemAtLeast(10, 0, 0) {
            guard let _classs = NSClassFromString("UINavigationItemView") else {
                assertionFailure("无法获取到 UINavigationItemView 类")
                return nil
            }
            classs = _classs
        } else {
            return nil
        }

        guard let view = self.subviews.first(where: {$0.isMember(of: classs)}) else {
            //assertionFailure("无法获取到subviews中是 _UINavigationBarContentView 的view")
            return nil
        }
        return view
    }

    /*
    public var rnb_promptView:UIView? {
        guard let classs = NSClassFromString("_UINavigationBarModernPromptView") else {return nil}
        let _view = self.subviews.first(where: {$0.isMember(of: classs)})
        return _view
    }
     */

    /*
    private var rnb_barTintColorView:UIView? {
        //when translucent, the barTintColor is on a visualEffect view that alpha == 0.85
        //when not translucent, it is on a UIImageView which size equals to barBackgroundView
        //check visualEffectView first
        guard let _backgroundView = self.rnb_barBackgroundView else {return nil}
        if let effectView1 = _backgroundView.subviews.first(where: {$0.isMember(of: UIVisualEffectView.self) && $0.frame == _backgroundView.bounds}) {
            //have a visualEffectView
            //这里的判断条件不可以精确判断,会判断为false, 用一个范围来替代, alpha的值大约是在0.85
            guard let view = effectView1.subviews.first(where: {$0.isMember(of: NSClassFromString("_UIVisualEffectSubview")!) && (0.84...0.86).contains($0.alpha) && $0.frame==effectView1.bounds}) else {
                //assertionFailure("无法找到alpha为0.85的显示barTint的view")
                return nil
            }
            return view
        }else if let colorAndImageView1 = _backgroundView.subviews.first(where: {$0.frame == _backgroundView.bounds && $0.isMember(of: UIImageView.self)}){
            return colorAndImageView1
        }
        assertionFailure("无法获取到 barTintColorView")
        return nil
    }
     */

    ///获取title的View
    public var rnb_titleLabel:UILabel? {
        let label = self.rnb_barContentView?.subviews.first(where: {$0.isMember(of: UILabel.self)}) as? UILabel
        return label
    }

    ///获取返回按钮的View
    public var rnb_backButton:UIView? {
        guard let _UIButtonBarButton = NSClassFromString("_UIButtonBarButton") else {return nil}
        let _button = self.rnb_barContentView?.subviews.first(where: {$0.isMember(of: _UIButtonBarButton)})
        return _button
    }

    ///获取显示按钮的所有stackView
    internal var rnb_buttonBarStackViews:[UIView] {
        guard let _UIButtonBarStackView = NSClassFromString("_UIButtonBarStackView") else {return []}
        guard let stackViews = self.rnb_barContentView?.subviews.filter({$0.isMember(of: _UIButtonBarStackView)}) else {return []}
        return stackViews
    }

    /*
    ///may not be the left stack in some specific situations
    public var rnb_leftButtonStackView:UIView? {
        let stackViews = self.rnb_buttonBarStackViews
        switch stackViews.count {
        case 0:
            return nil
        case 2:
            return stackViews.first
        default:
            return stackViews.first(where: {$0.frame.origin.x < 16})
        }
    }

    ///may not be the right stack in some specific situations
    public var rnb_rightButtonStackView:UIView? {
        let stackViews = self.rnb_buttonBarStackViews
        switch stackViews.count {
        case 0:
                return nil
        case 2:
            return stackViews.last
        default:
            return stackViews.first(where: {(self.bounds.width - ($0.frame.origin.x+$0.frame.width) < 16)})
        }
    }
     */

    ///all buttons including backButton
    public var rnb_stackButtons:[UIView] {
        var buttons:[UIView] = []

        if let backButton = self.rnb_backButton {
            buttons.append(backButton)
        }

        let stackViews = self.rnb_buttonBarStackViews
        if let _UIButtonBarButton = NSClassFromString("_UIButtonBarButton") {
            for i in stackViews {
                buttons.append(contentsOf: i.subviews.filter({$0.isMember(of: _UIButtonBarButton)}))
            }
        }
        return buttons
    }

}
