//
//  ExampleMenuViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ExampleMenuViewController: UITableViewController {

    enum Row: Int {
        case weibo = 0
        case count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example"
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
        case .weibo:
            vc = WeiboExampleViewController()
        default:
            return
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
