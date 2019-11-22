//
//  StatusBarStyleTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class StatusBarStyleTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch self.navigationController?.viewControllers.firstIndex(of: self) ?? 0 % 2 {
        case 1:
            self.rnb_setStatusBarStyle(.lightContent)
        case 0:
            if #available(iOS 13, *) {
                self.rnb_setStatusBarStyle(.darkContent)
            }else {
                self.rnb_setStatusBarStyle(.default)
            }
        default:
            break
        }

    }

    override func nextViewController() -> UIViewController {
        return StatusBarStyleTestViewController()
    }

}
