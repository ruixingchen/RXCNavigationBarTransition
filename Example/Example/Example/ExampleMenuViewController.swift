//
//  ExampleMenuViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ExampleMenuViewController: UITableViewController {

    enum Row: Int, CustomStringConvertible {
        case weibo = 0
        case qq_app
        case ant
        case count

        var description: String {
            switch self {
            case .weibo:
                return "微博个人中心"
            case .qq_app:
                return "QQ应用中心"
            case .ant:
                return "蚂蚁森林"
            case .count:
                return "ERROR"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarForegroundColor(UIColor.orange)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        cell.textLabel?.text = row.description
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = Row.init(rawValue: indexPath.row)!
        let vc:UIViewController
        switch row {
        case .weibo:
            vc = WeiboExampleViewController()
        case .qq_app:
            vc = QQApplicationExampleViewController()
        case .ant:
            vc = AntExampleViewController()
        default:
            return
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
