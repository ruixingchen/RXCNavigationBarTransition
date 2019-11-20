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

        self.rnb_setNavigationBarBarTintColor(UIColor.red)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            //self.navigationController?.navigationBar.barTintColor = UIColor.blue.withAlphaComponent(0.0)
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
//        self.rnb_setNavigationBarShadowViewHidden(true)
        self.rnb_setNavigationBarBarTintColor(UIColor.blue)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //print(self.navigationController?.poppingViewController)

    }

}
