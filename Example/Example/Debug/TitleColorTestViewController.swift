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
        self.rnb_setNavigationBarTitleColor(UIColor.random())
    }

    override func nextViewController() -> UIViewController {
        return TitleColorTestViewController()
    }

}
