//
//  BackgroundColorTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

import UIKit

class BackgroundColorTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundColor(UIColor.orange)
    }

    override func nextViewController() -> UIViewController {
        return BackgroundColorTestViewController2()
    }

}

fileprivate class BackgroundColorTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundColor(UIColor.clear)
    }

    override func nextViewController() -> UIViewController {
        return BackgroundColorTestViewController3()
    }

}

fileprivate class BackgroundColorTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundColor(UIColor.cyan)
    }

}
