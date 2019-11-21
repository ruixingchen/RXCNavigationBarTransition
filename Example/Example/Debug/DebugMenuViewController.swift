//
//  DebugMenuViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class DebugMenuViewController: UITableViewController {

    enum Row: Int {
        case alpha = 0
        case backgroundAlpha
        case backgroundColor
        case tintColor
        case titleColor
        case shadowHidden
        case statusBarStyle
        case count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Debug"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.count.rawValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = Row.init(rawValue: indexPath.row)!
        cell.textLabel?.text = "\(row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = Row.init(rawValue: indexPath.row)!
        let vc:UIViewController
        switch row {
        case .alpha:
            vc = AlphaTestViewController()
        case .backgroundAlpha:
            vc = BackgroundAlphaTestViewController()
        case .backgroundColor:
            vc = BackgroundColorTestViewController()
        case .tintColor:
            vc = TintColorTestViewController()
        case .titleColor:
            vc = TitleColorTestViewController()
        case .shadowHidden:
            vc = ShadowHiddenTestViewController()
        case .statusBarStyle:
            vc = StatusBarStyleTestViewController()
        default:
            return
        }
        //vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
