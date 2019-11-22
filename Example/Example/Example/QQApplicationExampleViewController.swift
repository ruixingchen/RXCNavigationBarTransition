//
//  QQApplicationExampleViewController.swift
//  Example
//
//  Created by ruixingchen on 11/22/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCFirstTimeViewController

class QQApplicationExampleViewController: RXCFirstTimeViewController, UITableViewDataSource, UITableViewDelegate {

    let headerView = UIImageView()

    let headerHeight:CGFloat = 260
    let scrollDownLimit:CGFloat = 100

    let tableView:UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.headerView.clipsToBounds = true
        self.headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "qq_app_header")
        self.tableView.addSubview(self.headerView)
    }

    override func rxc_viewWillAppear_first(_ animated: Bool) {
        super.rxc_viewWillAppear_first(animated)
        self.rnb_setNavigationBarBackgroundAlpha(0)
        self.rnb_setNavigationBarTintColor(UIColor.white)
    }

    override func rxc_viewDidAppear_first(_ animated: Bool) {
        super.rxc_viewDidAppear_first(animated)
        self.rnb_setNavigationBarForegroundColor(UIColor(red: 50.0/255, green: 164.0/255, blue: 232.0/255, alpha: 1.0))
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

    ///刚好完全不透明的offset
    var opaqueCriticalOffset:CGFloat {
        guard let bar = self.navigationController?.navigationBar else {return 0}
        let barFrame = bar.convert(bar.bounds, to: self.view)
        return -(barFrame.origin.y + barFrame.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.tableView else {return}
        guard self.navigationController != nil else {return}
        let offset = scrollView.contentOffset.y
        if offset > self.opaqueCriticalOffset {
            //显示颜色
            UIView.animate(withDuration: 0.25) {
                self.rnb_setNavigationBarBackgroundAlpha(1.0)
            }
        }else {
            //变为透明
            UIView.animate(withDuration: 0.25) {
                self.rnb_setNavigationBarBackgroundAlpha(0.0)
            }
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
