//
//  MainMenuViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        default: return 7
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var text:String?
        if indexPath.section == 0 {
            text = "example"
        }else if indexPath.section == 1 {
            text = "综合测试"
        }else {
            switch indexPath.row {
            case 0: text = "alpha"
            case 1: text = "background alpha"
            case 2: text = "forground color"
            case 3: text = "tint color"
            case 4: text = "title color"
            case 5: text = "shadow hidden"
            case 6: text = "statusBar style"
            default:break
            }
        }
        cell.textLabel?.text = text
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {

        }else if indexPath.section == 1 {
            let nav = UINavigationController.init(rootViewController: AllTestViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }else {
            var vc:UIViewController?
            switch indexPath.row {
            case 0://alpha
                vc = AlphaTestViewController()
            case 1: //"background alpha"
                vc = BackgroundAlphaTestViewController()
            case 2: //"forground color"
                vc = BackgroundColorTestViewController()
            case 3: //"tint color"
                vc = TintColorTestViewController()
            case 4: //"title color"
                vc = TitleColorTestViewController()
            case 5: //"shadow hidden"
                vc = ShadowHiddenTestViewController()
            case 6: //"statusBar style"
                vc = StatusBarStyleTestViewController()
            default:break
            }
            let nav = UINavigationController(rootViewController: vc!)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }

}
