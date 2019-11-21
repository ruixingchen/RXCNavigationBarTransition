//
//  BaseSingleTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class BaseSingleTestViewController: UITableViewController {

    init() {
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test 0"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }

    @objc func didTapDone() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "push with animation"
        case 1:
            cell.textLabel?.text = "push without animation"
        default:
            break
        }
        return cell
    }

    func nextViewController()->UIViewController {
        return UIViewController()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(self.nextViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(self.nextViewController(), animated: false)
        default:
            break
        }
    }

}

class BaseSingleTestViewController2: UITableViewController {

    init() {
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test 1"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "push with animation"
            case 1:
                cell.textLabel?.text = "push without animation"
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "pop with animation"
            case 1:
                cell.textLabel?.text = "pop without animation"
            default:
                break
            }
        default:
            break
        }
        return cell
    }

    func nextViewController()->UIViewController {
        return UIViewController()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(self.nextViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(self.nextViewController(), animated: false)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.navigationController?.popViewController(animated: true)
            case 1:
                self.navigationController?.popViewController(animated: false)
            default:
                break
            }
        default:
            break
        }
    }

}

class BaseSingleTestViewController3: UITableViewController {

    init() {
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test 2"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarAlpha(1.0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "pop with animation"
        case 1:
            cell.textLabel?.text = "pop without animation"
        default:
            break
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.popViewController(animated: true)
        case 1:
            self.navigationController?.popViewController(animated: false)
        default:
            break
        }
    }

}
