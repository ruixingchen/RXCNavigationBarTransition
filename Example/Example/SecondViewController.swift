//
//  SecondViewController.swift
//  Example
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCNavigationBarTransition

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        self.rnb_navigationBarBarTintColor = .setted(UIColor.blue)
        self.rnb_navigationBarAlpha = .setted(1)

        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "按钮1", style: .plain, target: nil, action: nil)
        var rightButtons:[UIBarButtonItem] = []
        for i in  0..<3 {
            rightButtons.append(UIBarButtonItem(title: "按钮2", style: .plain, target: nil, action: nil))
        }
        self.navigationItem.rightBarButtonItems = rightButtons
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.rnb_navigationBarAlpha = 0
    }
    @IBAction func didTapPopButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
