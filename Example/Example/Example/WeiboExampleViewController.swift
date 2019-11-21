//
//  WeiboExampleViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class WeiboExampleViewController: UITableViewController {

    let headerView = HeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = headerView
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.headerView.frame == CGRect.zero {
            self.headerView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 200)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "RXCNavigationBar \(indexPath.row)"
        return cell
    }

}

extension WeiboExampleViewController {

    class HeaderView: UIView {

        let logoView:UIImageView = UIImageView()
        let userNameLabel = UILabel()
        let followNumLabel = UILabel()
        let descriptionLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(self.logoView)
            self.logoView.image = UIImage(named: "myLogo")
            self.userNameLabel.text = "ruixingchen"
            self.followNumLabel.text = "关注 999 | 粉丝 0 (惨)"
            self.descriptionLabel.text = "简介: 别急, 这个Bug我马上就能修好"
            self.addSubview(self.userNameLabel)
            self.addSubview(self.followNumLabel)
            self.addSubview(self.descriptionLabel)
            self.logoView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(128)
                make.width.equalTo(64)
                make.height.equalTo(64)
            }
            self.userNameLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.logoView.snp.bottom).offset(8)
            }
            self.followNumLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.userNameLabel.snp.bottom).offset(8)
            }
            self.descriptionLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.followNumLabel.snp.bottom).offset(8)
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

}
