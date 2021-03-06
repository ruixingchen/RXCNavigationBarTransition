//
//  AlphaTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class AlphaTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch (self.navigationController?.viewControllers.firstIndex(of: self) ?? 0) % 3 {
        case 1:
            self.rnb_setNavigationBarAlpha(0.0)
        case 2:
            self.rnb_setNavigationBarAlpha(1.0)
        case 0:
            self.rnb_setNavigationBarAlpha(CGFloat.random(in: 0...1))
        default:
            break
        }
    }

    override func nextViewController() -> UIViewController {
        return AlphaTestViewController()
    }

}
