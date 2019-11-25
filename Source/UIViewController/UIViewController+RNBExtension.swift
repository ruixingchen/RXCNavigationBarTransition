//
//  UIViewController+RNBExtension.swift
//  Example
//
//  Created by ruixingchen on 11/25/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

extension UIViewController {

    public func rnb_isEmbededInNavigationController()->Bool {
        return self.navigationController != nil
    }

    public func rnb_isNavRootViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.viewControllers.first === self
    }

    public func rnb_isNavTopViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.topViewController === self
    }

    public func rnb_isNavOnlyViewController()->Bool {
        guard let nav = self.navigationController else {return false}
        return nav.viewControllers.count == 1 && nav.viewControllers.first == self
    }

}
