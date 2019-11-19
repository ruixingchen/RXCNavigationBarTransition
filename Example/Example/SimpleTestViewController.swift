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
        self.view.backgroundColor = UIColor.brown
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let shadowView = self.navigationController?.navigationBar.rnb_shadowView
        shadowView?.subviews.first?.frame.size.height = 10
        self.rnb_navigationBarShadowViewHidden = RNBSetting.setted(false)
        self.navigationController?.navigationBar.rnb_shadowView?.addObserver(self, forKeyPath: "alpha", options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "alpha" {
            print(change?[NSKeyValueChangeKey.newKey])
        }

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
        self.view.backgroundColor = UIColor.orange
        self.title = "title_2"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let shadowView = self.navigationController?.navigationBar.rnb_shadowView
        shadowView?.subviews.first?.frame.size.height = 10
        self.rnb_navigationBarShadowViewHidden = RNBSetting.setted(true)
    }

}
