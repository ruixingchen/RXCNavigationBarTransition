//
//  BackgroundAlphaTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class BackgroundAlphaTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundAlpha(1.0)
    }

    override func nextViewController() -> UIViewController {
        return BackgroundAlphaTestViewController2()
    }

}

fileprivate class BackgroundAlphaTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundAlpha(0.0)
    }

    override func nextViewController() -> UIViewController {
        return BackgroundAlphaTestViewController3()
    }

}

fileprivate class BackgroundAlphaTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarBackgroundAlpha(1.0)
    }
    
}
