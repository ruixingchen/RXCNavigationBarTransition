//
//  ShadowHiddenTestViewController.swift
//  Example
//
//  Created by ruixingchen on 11/21/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

class ShadowHiddenTestViewController: BaseSingleTestViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let _view = UIView()
        _view.backgroundColor = UIColor.black
        if let visualView = self.navigationController?.navigationBar.rnb_shadowView as? UIVisualEffectView {
            visualView.contentView.addSubview(_view)
        }else {
            self.navigationController?.navigationBar.rnb_shadowView?.addSubview(_view)
        }
        _view.frame = self.navigationController?.navigationBar.rnb_shadowView?.bounds ?? CGRect(x: 0, y: 0, width: 100, height: 10)
        _view.frame.size.height = 10
        self.rnb_setNavigationBarShadowViewHidden(false)
    }

    override func nextViewController() -> UIViewController {
        return ShadowHiddenTestViewController2()
    }

}

fileprivate class ShadowHiddenTestViewController2: BaseSingleTestViewController2 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarShadowViewHidden(true)
    }

    override func nextViewController() -> UIViewController {
        return ShadowHiddenTestViewController3()
    }

}

fileprivate class ShadowHiddenTestViewController3: BaseSingleTestViewController3 {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rnb_setNavigationBarShadowViewHidden(false)
    }

}
