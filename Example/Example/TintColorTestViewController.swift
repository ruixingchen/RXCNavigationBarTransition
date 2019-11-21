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
        self.rnb_setNavigationBarTintColor(UIColor.orange)
    }

    override func nextViewController() -> UIViewController {
        return TintColorTestViewController2()
    }

}

fileprivate class TintColorTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarTintColor(UIColor.clear)
    }

    override func nextViewController() -> UIViewController {
        return TintColorTestViewController3()
    }

}

fileprivate class TintColorTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarTintColor(UIColor.black)
    }

}
