//
//  TintColorTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class TintColorTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarTintColor(UIColor.random())
    }

    override func nextViewController() -> UIViewController {
        return TintColorTestViewController()
    }

}
