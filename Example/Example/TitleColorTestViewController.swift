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
        self.rnb_setNavigationBarTitleColor(UIColor.orange)
    }

    override func nextViewController() -> UIViewController {
        return TitleColorTestViewController2()
    }

}

fileprivate class TitleColorTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarTitleColor(UIColor.clear)
    }

    override func nextViewController() -> UIViewController {
        return TitleColorTestViewController3()
    }

}

fileprivate class TitleColorTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarTitleColor(UIColor.black)
    }

}
