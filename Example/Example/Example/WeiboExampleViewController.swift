//
//  WeiboExampleViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCFirstTimeViewController

class WeiboExampleViewController: RXCFirstTimeViewController, UITableViewDataSource, UITableViewDelegate {

    let headerView = HeaderView()

    let tableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }

        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.tableHeaderView = headerView
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.tableView.tableHeaderView = headerView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func rxc_viewWillAppear_first(_ animated: Bool) {
        super.rxc_viewWillAppear_first(animated)
        self.rnb_setNavigationBarBackgroundAlpha(0)
        self.rnb_setNavigationBarTintColor(UIColor.white)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.headerView.setNeedsLayout()
        self.headerView.layoutIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bottom:CGFloat
        if #available(iOS 11, *) {
            bottom = self.view.safeAreaInsets.bottom
        }else {
            bottom = self.bottomLayoutGuide.length
        }
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "RXCNavigationBar \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    ///刚好完全不透明的offset
    var opaqueCriticalOffset:CGFloat {
        guard let bar = self.navigationController?.navigationBar else {return 0}
        let barFrame = bar.convert(bar.bounds, to: self.view)
        let headerFrame = self.headerView.bounds
        let offset = headerFrame.height - (barFrame.origin.y+barFrame.height)
        return offset
    }

    ///刚好完全透明的offset
    var transparentCriticalOffset:CGFloat {
        return self.opaqueCriticalOffset - self.navigationController!.navigationBar.frame.height
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.tableView else {return}
        guard self.navigationController != nil else {return}
        let offset = scrollView.contentOffset.y
        var alpha:CGFloat = 1 - (offset - opaqueCriticalOffset) / (transparentCriticalOffset-opaqueCriticalOffset)
        alpha = max(0, alpha)
        alpha = min(1, alpha)
        print("设置alpha:\(alpha)")
        self.rnb_setNavigationBarBackgroundAlpha(alpha)
        if alpha > 0.5 {
            self.title = "ruixingchen"
            self.rnb_setNavigationBarTintColor(UIColor.black)
            self.rnb_setNavigationBarTitleColor(UIColor.black)
            self.rnb_setStatusBarStyle(.default)
        }else {
            self.title = nil
            self.rnb_setNavigationBarTintColor(UIColor.white)
            self.rnb_setNavigationBarTitleColor(UIColor.white)
            self.rnb_setStatusBarStyle(.lightContent)
        }
    }

}

extension WeiboExampleViewController {

    class HeaderView: UIView {

        let backgroundImageView:UIImageView = UIImageView()
        let logoView:UIImageView = UIImageView()
        let userNameLabel = UILabel()
        let followNumLabel = UILabel()
        let descriptionLabel = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundImageView.image = UIImage(named: "weibo_background")
            self.backgroundImageView.contentMode = .scaleAspectFill
            self.backgroundImageView.clipsToBounds = true
            self.logoView.image = UIImage(named: "myLogo")
            self.logoView.layer.cornerRadius = 32
            self.logoView.layer.masksToBounds = true
            self.userNameLabel.text = "ruixingchen"
            self.followNumLabel.text = "关注 999 | 粉丝 0 (惨)"
            self.descriptionLabel.text = "简介: 别急, 这个Bug我肯定能修好"
            self.addSubview(self.backgroundImageView)
            self.addSubview(self.logoView)
            self.addSubview(self.userNameLabel)
            self.addSubview(self.followNumLabel)
            self.addSubview(self.descriptionLabel)
            
            self.subviews.forEach({($0 as? UILabel)?.textColor = UIColor.white})

            self.logoView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(100)
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
                make.bottom.equalToSuperview().offset(-8)
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            self.backgroundImageView.frame = self.bounds
        }

    }

}
