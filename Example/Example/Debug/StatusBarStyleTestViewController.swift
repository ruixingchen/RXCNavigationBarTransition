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
        if self.navigationController?.viewControllers.firstIndex(of: self)?.isMultiple(of: 2) ?? false {
            if #available(iOS 13, *) {
                self.rnb_setStatusBarStyle(.darkContent)
            }else {
                self.rnb_setStatusBarStyle(.default)
            }
        }else {
            self.rnb_setStatusBarStyle(.lightContent)
        }

    }

    override func nextViewController() -> UIViewController {
        return StatusBarStyleTestViewController()
    }

}
