//
//  SimpleTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/18/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCNavigationBarTransition
import SnapKit

class SimpleTestViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rnb_navigationBarBarTintColor = RNBSetting.setted(UIColor.orange)
//        self.rnb_navigationBarAlpha = RNBSetting.setted(1.0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.rnb_navigationBarBarTintColor = RNBSetting.setted(UIColor.orange)
//        self.rnb_navigationBarAlpha = RNBSetting.setted(1.0)
    }

    @IBAction func didTapButton(_ sender: Any) {
        let vc = SimpleTestViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didTapDone(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}

class SimpleTestViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rnb_navigationBarBarTintColor = RNBSetting.setted(UIColor.blue)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.rnb_navigationBarBarTintColor = RNBSetting.setted(UIColor.red)
    }

}
