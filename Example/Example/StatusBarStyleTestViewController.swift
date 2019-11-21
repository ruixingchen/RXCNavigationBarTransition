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
        self.rnb_setStatusBarStyle(.lightContent)
    }

    override func nextViewController() -> UIViewController {
        return StatusBarStyleTestViewController2()
    }

}

fileprivate class StatusBarStyleTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setStatusBarStyle(.default)
    }

    override func nextViewController() -> UIViewController {
        return StatusBarStyleTestViewController3()
    }

}

fileprivate class StatusBarStyleTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setStatusBarStyle(.lightContent)
    }

}
