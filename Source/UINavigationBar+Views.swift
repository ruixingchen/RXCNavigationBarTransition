//
//  UINavigationBar+Views.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UINavigationBar {

    public var rnb_shadowView:UIView? {
        for i in self.subviews {
            for j in i.subviews {
                let _frame = j.frame
                if _frame.origin.x == 0 && _frame.origin.y == self.bounds.height && _frame.width == self.bounds.width && _frame.height < 1 {
                    return j
                }
            }
        }
        return nil
    }

    public var rnb_barBackgroundView:UIView? {
        guard let classs = NSClassFromString("_UIBarBackground") else {return nil}
        guard let view = self.subviews.first(where: {$0.isMember(of: classs)}) else {return nil}
        guard view.frame.origin.x == 0 && view.frame.origin.y + view.frame.size.height == self.bounds.height && view.frame.width == self.bounds.width else {return nil}
        return view
    }

    public var rnb_barContentView:UIView? {
        guard let classs = NSClassFromString("_UINavigationBarContentView") else {return nil}
        guard let view = self.subviews.first(where: {$0.isMember(of: classs)}) else {return nil}
        guard view.frame == self.bounds else {return nil}
        return view
    }

//    public var rnb_promptView:UIView? {
//        guard let classs = NSClassFromString("_UINavigationBarModernPromptView") else {return nil}
//        let _view = self.subviews.first(where: {$0.isMember(of: classs)})
//        return _view
//    }

    public var rnb_barTintColorView:UIView? {
        //when translucent, the barTintColor is on a visualEffect view that alpha == 0.85
        //when not translucent, it is on a UIImageView with size equal to barBackgroundView
        //check visualEffectView first
        guard let _backgroundView = self.rnb_barBackgroundView else {return nil}
        if let effectView1 = _backgroundView.subviews.first(where: {$0.isMember(of: UIVisualEffectView.self) && $0.frame == _backgroundView.bounds}) {
            //have a visualEffectView
            guard let view = effectView1.subviews.first(where: {$0.isMember(of: NSClassFromString("_UIVisualEffectSubview")!) && $0.alpha < 1 && $0.frame==effectView1.bounds}) else {return nil}
            return view
        }else if let colorAndImageView1 = _backgroundView.subviews.first(where: {$0.frame == _backgroundView.bounds && $0.isMember(of: UIImageView.self)}){
            return colorAndImageView1
        }
        return nil
    }

    public var rnb_titleLabel:UILabel? {
        let label = self.rnb_barContentView?.subviews.first(where: {$0.isMember(of: UILabel.self)}) as? UILabel
        return label
    }

    public var rnb_backButton:UIView? {
        guard let _UIButtonBarButton = NSClassFromString("_UIButtonBarButton") else {return nil}
        let _button = self.rnb_barContentView?.subviews.first(where: {$0.isMember(of: _UIButtonBarButton)})
        return _button
    }

    public var rnb_buttonBarStackViews:[UIView] {
        guard let _UIButtonBarStackView = NSClassFromString("_UIButtonBarStackView") else {return []}
        guard let stackViews = self.rnb_barContentView?.subviews.filter({$0.isMember(of: _UIButtonBarStackView)}) else {return []}
        return stackViews
    }

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
