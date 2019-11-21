//
//  ShadowHiddenTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ShadowHiddenTestViewController: BaseSingleTestViewController {

    static let indicatorView = UIView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let shadowView = self.navigationController?.navigationBar.rnb_shadowView
        let _view = Self.indicatorView
        _view.backgroundColor = UIColor.black
        if let visualView = self.navigationController?.navigationBar.rnb_shadowView as? UIVisualEffectView {
            if !visualView.contentView.contains(_view) {
                visualView.contentView.addSubview(_view)
            }
        }else if !(shadowView?.contains(_view) ?? false) {
            shadowView?.addSubview(_view)
        }
        _view.frame = self.navigationController?.navigationBar.rnb_shadowView?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 10)
        _view.frame.size.height = 10
        self.rnb_setNavigationBarShadowViewHidden(!(self.navigationController?.viewControllers.firstIndex(of: self)?.isMultiple(of: 2) ?? false))
    }

    override func nextViewController() -> UIViewController {
        return ShadowHiddenTestViewController()
    }

}
