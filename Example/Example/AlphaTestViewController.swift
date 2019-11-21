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
        self.rnb_setNavigationBarAlpha(1.0)
    }

    override func nextViewController() -> UIViewController {
        return AlphaTestViewController2()
    }

}

fileprivate class AlphaTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarAlpha(0.0)
    }

    override func nextViewController() -> UIViewController {
        return AlphaTestViewController3()
    }

}

fileprivate class AlphaTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarAlpha(1.0)
    }

}
