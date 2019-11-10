//
//  RNBHelper.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

public struct RNBHelper {

    ///is current OS version >= a specific version
    public static func isOperatingSystemAtLeast(_ version:OperatingSystemVersion)->Bool {
        return ProcessInfo.processInfo.isOperatingSystemAtLeast(version)
    }

    ///as the name says
    public static func isRoundCornerScreen()->Bool {
        let insets:UIEdgeInsets = UIApplication.shared.windows.first!.safeAreaInsets
        return insets.top > 0 || insets.right > 0 || insets.bottom > 0 || insets.left > 0
    }

    ///the content height of the navigation bar
    public static func defaultNavigationBarContentHeight()->CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if #available(iOS 12.0, *) {
                return 50
            }
        }
        return 44
    }

    ///the content height of the tab bar
    public static func defaultTabBarContentHeight()->CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if #available(iOS 12.0, *) {
                return 50
            }
        }
        return 49
    }

    ///as the name says
    public static func screenWidth()->CGFloat {
        return UIScreen.main.bounds.size.width
    }

    ///as the name says
    public static func screenHeight()->CGFloat {
        return  UIScreen.main.bounds.size.height
    }

    ///as the name says, but self is excluded
    public static func findClosestNavigationController(for object:UIResponder)->UINavigationController? {
        var current:UIResponder? = object.next
        while current != nil {
            if let nav = current as? UINavigationController {
                return nav
            }
            current = current?.next
        }
        return nil
    }

    ///as the name says, but self is excluded
    public static func findClosestTabBarController(for object:UIResponder)->UITabBarController? {
        var current:UIResponder? = object.next
        while current != nil {
            if let tab = current as? UITabBarController {
                return tab
            }
            current = current?.next
        }
        return nil
    }

}

extension RNBHelper {

    internal static func chooseSettedValue<T>(setting:RNBSetting<T>, setting2:RNBSetting<T>?, defaultValue:T)->T {
        switch setting {
        case .setted(let value):
            return value
        case .notset:
            if let setting2 = setting2 {
                switch setting2 {
                case .setted(let value2):
                    return value2
                case .notset:
                    return defaultValue
                }
            }else {
                return defaultValue
            }
        }
    }

    ///as the name says
    public static func calculateProgressiveColor(from:UIColor, to:UIColor, progress:CGFloat)->UIColor {
        var fromR:CGFloat=0, fromG:CGFloat=0, fromB:CGFloat=0, fromA:CGFloat=0
        from.getRed(&fromR, green: &fromG, blue: &fromB, alpha: &fromA)
        var toR:CGFloat=0, toG:CGFloat=0, toB:CGFloat=0, toA:CGFloat=0
        to.getRed(&toR, green: &toG, blue: &toB, alpha: &toA)
        let color:UIColor = UIColor(red: fromR+(toR-fromR)*progress, green: fromG+(toG-fromG)*progress, blue: fromB+(toB-fromB)*progress, alpha: fromA+(toA-fromA)*progress)
        return color
    }

    ///as the name says
    public static func calculateProgressiveAlpha(from:CGFloat, to:CGFloat, progress:CGFloat)->CGFloat {
        let alpha = from + (to-from)*progress
        return alpha
    }

}

public extension RNBHelper {

    //these are system default values

    static let systemDefaultNavigationBarAlpha:CGFloat = 1.0
    static let systemDefaultNavigationBarBackgroundAlpha:CGFloat = 1.0
    ///在translucent模式下是没有颜色的, 默认采用透明模式的颜色, 在不透明模式下是systemBackground
    static var systemDefaultNavigationBarBarTintColor:UIColor = {
        if #available(iOS 13, *) {
            return UIColor.systemBackground
        }else {
            return UIColor.white
        }
    }()

    static var systemDefaultNavigationBarTintColor:UIColor {
        if #available(iOS 13, *) {
            return UIColor.systemBlue
        }else {
            return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
        }
    }
    static var systemDefaultNavigationBarTitleColor:UIColor {
        if #available(iOS 13, *) {
            return UIColor.label
        }else {
            return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
        }
    }
    static let systemDefaultNavigationBarShadowViewHidden:Bool = false
    static let systemDefaultStatusBarStyle:UIStatusBarStyle = {
        guard let text = Bundle.main.object(forInfoDictionaryKey: "UIStatusBarStyle") as? String else {
            return UIStatusBarStyle.default
        }
        if #available(iOS 13.0, *) {
            if text == "UIStatusBarStyleDarkContent" {
                return UIStatusBarStyle.darkContent
            }
        }
        if text == "UIStatusBarStyleLightContent" {
            return UIStatusBarStyle.lightContent
        }
        return UIStatusBarStyle.default
    }()

}

internal func rnblog(_ closure:@autoclosure ()->Any, file:StaticString = #file,line:Int = #line,function:StaticString = #function) {
    #if (debug || DEBUG)
    let fileName = String(describing: file).components(separatedBy: "/").last ?? ""
    print("\(fileName):\(line) - \(function) : \(closure())")
    #endif
}
