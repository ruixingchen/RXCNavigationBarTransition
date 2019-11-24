//
//  AntExampleViewController.swift
//  Example
//
//  Created by ruixingchen on 11/22/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCFirstTimeViewController

class AntExampleViewController: RXCFirstTimeViewController, UITableViewDataSource, UITableViewDelegate {

    let headerView = UIImageView()

    let headerHeight:CGFloat = 480
    let scrollDownLimit:CGFloat = 0

    let tableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.headerView.clipsToBounds = true
        self.headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "ant_header")
        self.tableView.addSubview(self.headerView)
        self.title = "蚂蚁森林"
    }

    override func rxc_viewWillAppear_first(_ animated: Bool) {
        super.rxc_viewWillAppear_first(animated)
        self.rnb_setNavigationBarBackgroundAlpha(0)
        self.rnb_setNavigationBarShadowViewHidden(true)
        self.rnb_setNavigationBarTintColor(UIColor.white)
        self.rnb_setNavigationBarTitleColor(UIColor.white)
        self.rnb_setStatusBarStyle(.lightContent)
    }

    override func rxc_viewDidAppear_first(_ animated: Bool) {
        super.rxc_viewDidAppear_first(animated)
        self.rnb_setNavigationBarForegroundColor(UIColor.white)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bottom:CGFloat
        if #available(iOS 11, *) {
            bottom = self.view.safeAreaInsets.bottom
        }else {
            bottom = self.bottomLayoutGuide.length
        }
        self.tableView.contentInset = UIEdgeInsets(top: self.headerHeight, left: 0, bottom: bottom, right: 0)

        if true {
            var frame = self.headerView.frame
            frame.size.width = self.tableView.frame.width
            self.headerView.frame = frame
        }
    }

    override func rxc_viewDidLayoutSubviews_first() {
        super.rxc_viewDidLayoutSubviews_first()
        self.headerView.frame = CGRect(x: 0, y: -self.headerHeight, width: self.view.bounds.width, height: self.headerHeight)
        self.tableView.setContentOffset(CGPoint(x: 0, y: -self.headerHeight), animated: false)
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
    var transparentCriticalOffset:CGFloat {
        return -self.headerHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.tableView else {return}
        guard self.navigationController != nil else {return}
        let offset = scrollView.contentOffset.y
        let distance = offset - self.transparentCriticalOffset
        var alpha = distance / self.navigationController!.navigationBar.frame.height
        alpha = max(0, min(1, alpha))
        self.rnb_setNavigationBarBackgroundAlpha(alpha)
        if alpha >= 0.5 {
            self.rnb_setNavigationBarTintColor(RNBHelper.systemDefaultNavigationBarTintColor)
            self.rnb_setNavigationBarTitleColor(UIColor.black)
            if #available(iOS 13, *) {
                self.rnb_setStatusBarStyle(.darkContent)
            }else {
                self.rnb_setStatusBarStyle(.default)
            }
            self.rnb_setNavigationBarShadowViewHidden(false)
        }else {
            self.rnb_setNavigationBarTintColor(UIColor.white)
            self.rnb_setNavigationBarTitleColor(UIColor.white)
            self.rnb_setStatusBarStyle(.lightContent)
            self.rnb_setNavigationBarShadowViewHidden(true)
        }

        let offsetLimitation =  -self.scrollDownLimit-self.headerHeight
        if offset < offsetLimitation {
            self.tableView.contentOffset = CGPoint(x: 0, y: offsetLimitation)
        }
        //更新header的frame来拉伸图片
        let newOffset = scrollView.contentOffset.y
        if offset <= -headerHeight {
            self.headerView.frame = CGRect(x: 0, y: newOffset, width: self.tableView.frame.width, height: -newOffset)
        }else {
            self.headerView.frame = CGRect(x: 0, y: -self.headerHeight, width: self.tableView.frame.width, height: self.headerHeight)
        }
    }

}
