//
//  BackgroundAlphaTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class BackgroundAlphaTestViewController: BaseSingleTestViewController {

    let headerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.backgroundColor = UIColor.orange
        self.tableView.addSubview(self.headerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch (self.navigationController?.viewControllers.firstIndex(of: self) ?? 0) % 3 {
        case 1:
            self.rnb_setNavigationBarBackgroundAlpha(0.0)
        case 2:
            self.rnb_setNavigationBarBackgroundAlpha(1.0)
        case 0:
            self.rnb_setNavigationBarBackgroundAlpha(CGFloat.random(in: 0...1))
        default:
            break
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let offset = self.tableView.contentOffset.y
        self.headerView.frame = CGRect(x: 0, y: offset, width: self.view.bounds.width, height: max(0, -offset))
    }

    override func nextViewController() -> UIViewController {
        return BackgroundAlphaTestViewController()
    }

}
