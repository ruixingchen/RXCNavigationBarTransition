//
//  BackgroundAlphaTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class BackgroundAlphaTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.viewControllers.firstIndex(of: self)?.isMultiple(of: 2) ?? false {
            self.rnb_setNavigationBarBackgroundAlpha(1)
        }else {
            self.rnb_setNavigationBarBackgroundAlpha(CGFloat.random(in: 0...1))
        }
    }

    override func nextViewController() -> UIViewController {
        return BackgroundAlphaTestViewController()
    }

}
