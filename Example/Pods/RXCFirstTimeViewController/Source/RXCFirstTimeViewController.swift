//
//  RXCFirstTimeViewController.swift
//  Example
//
//  Created by ruixingchen on 2019/11/25.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    public static var ftv_debug:Bool = false

    ///start method exchange, no any queue safe guarantees, make sure will only be called once
    public static func ftv_start() {
        var selectors:[Selector] = [
            #selector(loadView),
            #selector(viewDidLoad),
            #selector(viewWillAppear(_:)),
            #selector(updateViewConstraints),
            #selector(viewWillLayoutSubviews),
            #selector(viewDidLayoutSubviews),
            #selector(viewDidAppear(_:)),
            #selector(viewWillDisappear(_:)),
            #selector(viewDidDisappear(_:)),

            #selector(willMove(toParent:)),
            #selector(didMove(toParent:))
        ]

        var newSelectors:[Selector] = [
            #selector(ftv_loadView),
            #selector(ftv_viewDidLoad),
            #selector(ftv_viewWillAppear(_:)),
            #selector(ftv_updateViewConstraints),
            #selector(ftv_viewWillLayoutSubviews),
            #selector(ftv_viewDidLayoutSubviews),
            #selector(ftv_viewDidAppear(_:)),
            #selector(ftv_viewWillDisappear(_:)),
            #selector(ftv_viewDidDisappear(_:)),

            #selector(ftv_willMove(toParent:)),
            #selector(ftv_didMove(toParent:))
        ]

        if #available(iOS 11, *) {
            selectors.append(#selector(viewLayoutMarginsDidChange))
            selectors.append(#selector(viewSafeAreaInsetsDidChange))
            newSelectors.append(#selector(ftv_viewLayoutMarginsDidChange))
            newSelectors.append(#selector(ftv_viewSafeAreaInsetsDidChange))
        }

        for i in selectors.enumerated() {
            guard let method = class_getInstanceMethod(self, i.element) else {
                assertionFailure("can not get instance method of: \(i)")
                continue
            }
            guard let newMethod = class_getInstanceMethod(self, newSelectors[i.offset]) else {
                assertionFailure("can not get new instance selector of: \(newSelectors[i.offset])")
                continue
            }
            method_exchangeImplementations(method, newMethod)
        }
    }

}

internal func ftvlog(_ closure:@autoclosure ()->Any, file:StaticString = #file,line:Int = #line,function:StaticString = #function) {
    #if (debug || DEBUG)
    if UIViewController.ftv_debug {
        let fileName = String(describing: file).components(separatedBy: "/").last ?? ""
        print("\(fileName):\(line) - \(function) : \(closure())")
    }
    #endif
}
