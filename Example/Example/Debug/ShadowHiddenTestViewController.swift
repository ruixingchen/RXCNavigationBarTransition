//
//  ShadowHiddenTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ShadowHiddenTestViewController: BaseSingleTestViewController {

    static let indicatorView = UIView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch (self.navigationController?.viewControllers.firstIndex(of: self) ?? 0) % 2 {
        case 1:
            self.rnb_setNavigationBarShadowViewHidden(true)
        case 0:
            self.rnb_setNavigationBarShadowViewHidden(false)
        default:
            break
        }
    }

    override func nextViewController() -> UIViewController {
        return ShadowHiddenTestViewController()
    }

}
