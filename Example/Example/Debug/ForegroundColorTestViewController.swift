//
//  ForegroundColorTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/22/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ForegroundColorTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarForegroundColor(UIColor.random())
    }

    override func nextViewController() -> UIViewController {
        return ForegroundColorTestViewController()
    }

}
