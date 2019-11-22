//
//  TitleColorTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class TitleColorTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch self.navigationController?.viewControllers.firstIndex(of: self) ?? 0 % 3 {
        case 1:
            self.rnb_setNavigationBarTitleColor(UIColor.orange)
        case 2:
            self.rnb_setNavigationBarTitleColor(UIColor.clear)
        case 0:
            self.rnb_setNavigationBarTitleColor(UIColor.random())
        default:
            break
        }
    }

    override func nextViewController() -> UIViewController {
        return TitleColorTestViewController()
    }

}
