//
//  ViewController.swift
//  Example
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import SnapKit

internal func chooseSettedValue<T>(setting:RNBSetting<T>, setting2:RNBSetting<T>?, defaultValue:T)->T {
    switch setting {
    case .setted(let value):
        return value
    case .notset:
        if let setting2 = setting2 {
            switch setting2 {
            case .setted(let value2):
                return value2
            case .notset:
                return defaultValue
            }
        }else {
            return defaultValue
        }
    }
}

class AllTestViewController: UIViewController {

    let alphaTextLabel = UILabel()
    let alphaNumLabel: UILabel = UILabel()
    let alphaSlider: UISlider = UISlider()

    let backAlphaTextLabel: UILabel = UILabel()
    let backAlphaNumLabel: UILabel = UILabel()
    let backAlphaSlider: UISlider = UISlider()

    let backgroundColorTextLabel: UILabel = UILabel()
    let barTintPreviewView: UIView = UIView()
    let backgroundColorSlider: UISlider = UISlider()
    let backgroundColorAlphaSlider: UISlider = UISlider()

    let tintTextLabel: UILabel = UILabel()
    let tintPreviewView: UIView = UIView()
    let tintColorSlider: UISlider = UISlider()
    let tintAlphaSlider: UISlider = UISlider()

    let titleTextLabel: UILabel = UILabel()
    let titlePreviewView: UIView = UIView()
    let titleColorSlider: UISlider = UISlider()
    let titleAlphaSlider: UISlider = UISlider()

    let shadowTextLabel: UILabel = UILabel()
    let shadowSwitch: UISwitch = UISwitch()

    let statusBarTextLabel: UILabel = UILabel()
    let statusBarSegment: UISegmentedControl = UISegmentedControl(items: ["default", "dark", "light"])

    //第一行
    let applyButton = UIButton(type: .system)

    //第二行
    let randomColorButton = UIButton(type: .system)
    let randomColorAndApplyButton = UIButton(type: .system)

    //第三行
    let applyAsNavDefaultButton = UIButton(type: .system)
    let applyAsDefaultButton = UIButton(type: .system)

    //第四行
    let pushButton = UIButton(type: .system)
    let pushWithRandomColorButton = UIButton(type: .system)

    let scrollView:UIScrollView = UIScrollView()
    let contentView = UIView()

    ///外部设置的style, 将会被应用到本地View和navBar上
    var outSettedStyle:RNBNavigationBarStyle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = true
        self.arrangeSubviews()
        if self.navigationController?.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone(_:)))
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.scrollView.frame = self.view.bounds
        //self.scrollView.contentSize = self.view.bounds.size
        self.contentView.frame = self.view.bounds
    }

    func arrangeSubviews() {
        self.scrollView.backgroundColor = UIColor.orange
        self.extendedLayoutIncludesOpaqueBars = true

        func applyTextLabel(label:UILabel, text:String) {
            label.textAlignment = .left
            label.text = text
            label.font = UIFont.systemFont(ofSize: 14)
            label.adjustsFontSizeToFitWidth = true
        }

        func applySlider(_ slider:UISlider, action:Selector) {
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.value = 1
            slider.addTarget(self, action: action, for: .valueChanged)
        }

        applyTextLabel(label: self.alphaTextLabel, text: "alpha")
        applyTextLabel(label: self.alphaNumLabel, text: "1.00")
        applySlider(self.alphaSlider, action: #selector(alphaSliderAction(_:)))
        self.contentView.addSubview(self.alphaTextLabel)
        self.contentView.addSubview(self.alphaNumLabel)
        self.contentView.addSubview(self.alphaSlider)
        self.alphaTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(8)
            make.width.equalTo(100)
        }
        self.alphaNumLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.alphaTextLabel)
            make.left.equalTo(self.alphaTextLabel.snp.right).offset(8)
            make.width.equalTo(50)
        }
        self.alphaSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.alphaTextLabel)
            make.left.equalTo(self.alphaNumLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        applyTextLabel(label: self.backAlphaTextLabel, text: "back alpha")
        applyTextLabel(label: self.backAlphaNumLabel, text: "1.00")
        applySlider(self.backAlphaSlider, action: #selector(backAlphaAction(_:)))
        self.contentView.addSubview(self.backAlphaTextLabel)
        self.contentView.addSubview(self.backAlphaNumLabel)
        self.contentView.addSubview(self.backAlphaSlider)
        self.backAlphaTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.alphaTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.backAlphaNumLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backAlphaTextLabel)
            make.left.equalTo(self.backAlphaTextLabel.snp.right).offset(8)
            make.width.equalTo(50)
        }
        self.backAlphaSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backAlphaTextLabel)
            make.left.equalTo(self.backAlphaNumLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        applyTextLabel(label: self.backgroundColorTextLabel, text: "background color")
        applySlider(self.backgroundColorSlider, action: #selector(backgroundColorAction(_:)))
        applySlider(self.backgroundColorAlphaSlider, action: #selector(barTintAlphaAction(_:)))
        self.contentView.addSubview(self.backgroundColorTextLabel)
        self.contentView.addSubview(self.barTintPreviewView)
        self.contentView.addSubview(self.backgroundColorSlider)
        self.contentView.addSubview(self.backgroundColorAlphaSlider)
        self.backgroundColorTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.backAlphaTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.barTintPreviewView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backgroundColorTextLabel)
            make.left.equalTo(self.backgroundColorTextLabel.snp.right).offset(8)
            make.height.equalTo(self.backgroundColorTextLabel)
            make.width.equalTo(50)
        }
        self.backgroundColorSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backgroundColorTextLabel)
            make.left.equalTo(self.barTintPreviewView.snp.right).offset(8)
        }
        self.backgroundColorAlphaSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backgroundColorTextLabel)
            make.left.equalTo(self.backgroundColorSlider.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(self.backgroundColorSlider)
        }

        applyTextLabel(label: self.tintTextLabel, text: "tint color")
        applySlider(self.tintColorSlider, action: #selector(tintColorAction(_:)))
        applySlider(self.tintAlphaSlider, action: #selector(tintAlphaAction(_:)))
        self.contentView.addSubview(self.tintTextLabel)
        self.contentView.addSubview(self.tintPreviewView)
        self.contentView.addSubview(self.tintColorSlider)
        self.contentView.addSubview(self.tintAlphaSlider)
        self.tintTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.backgroundColorTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.tintPreviewView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tintTextLabel)
            make.left.equalTo(self.tintTextLabel.snp.right).offset(8)
            make.height.equalTo(self.tintTextLabel)
            make.width.equalTo(50)
        }
        self.tintColorSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tintTextLabel)
            make.left.equalTo(self.tintPreviewView.snp.right).offset(8)
        }
        self.tintAlphaSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.tintTextLabel)
            make.left.equalTo(self.tintColorSlider.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(self.tintColorSlider)
        }

        applyTextLabel(label: self.titleTextLabel, text: "title color")
        applySlider(self.titleColorSlider, action: #selector(titleColorAction(_:)))
        applySlider(self.titleAlphaSlider, action: #selector(titleAlphaAction(_:)))
        self.contentView.addSubview(self.titleTextLabel)
        self.contentView.addSubview(self.titlePreviewView)
        self.contentView.addSubview(self.titleColorSlider)
        self.contentView.addSubview(self.titleAlphaSlider)
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.tintTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.titlePreviewView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleTextLabel)
            make.left.equalTo(self.titleTextLabel.snp.right).offset(8)
            make.height.equalTo(self.titleTextLabel)
            make.width.equalTo(50)
        }
        self.titleColorSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleTextLabel)
            make.left.equalTo(self.titlePreviewView.snp.right).offset(8)
        }
        self.titleAlphaSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleTextLabel)
            make.left.equalTo(self.titleColorSlider.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(self.titleColorSlider)
        }

        applyTextLabel(label: self.shadowTextLabel, text: "shadow hidden")
        //self.shadowSwitch.addTarget(self, action: #selector(shadowHiddenSwitchAction(_:)), for: .valueChanged)
        self.contentView.addSubview(self.shadowTextLabel)
        self.contentView.addSubview(self.shadowSwitch)
        self.shadowTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.titleTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.shadowSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shadowTextLabel)
            make.left.equalTo(self.shadowTextLabel.snp.right).offset(8)
        }

        applyTextLabel(label: self.statusBarTextLabel, text: "statusBar style")
        self.contentView.addSubview(self.statusBarTextLabel)
        self.contentView.addSubview(self.statusBarSegment)
        self.statusBarTextLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.shadowTextLabel.snp.bottom).offset(24)
            make.width.equalTo(100)
        }
        self.statusBarSegment.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.statusBarTextLabel)
            make.left.equalTo(self.statusBarTextLabel.snp.right).offset(8)
            //make.right.equalToSuperview().offset(-8)
        }

        //第一行
        self.applyButton.setTitle("apply", for: .normal)
        self.applyButton.addTarget(self, action: #selector(apply(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.applyButton)
        self.applyButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.statusBarTextLabel.snp.bottom).offset(8)
        }
        //第二行
        self.randomColorButton.setTitle("random color", for: .normal)
        self.randomColorButton.addTarget(self, action: #selector(randomColor(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.randomColorButton)
        self.randomColorAndApplyButton.setTitle("| random color and apply", for: .normal)
        self.randomColorAndApplyButton.addTarget(self, action: #selector(randomColorAndApply(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.randomColorAndApplyButton)
        self.randomColorButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.applyButton.snp.bottom).offset(8)
        }
        self.randomColorAndApplyButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.randomColorButton)
            make.left.equalTo(self.randomColorButton.snp.right).offset(8)
        }

        //第三行
        self.applyAsNavDefaultButton.setTitle("apply as Nav default", for: .normal)
        self.applyAsNavDefaultButton.addTarget(self, action: #selector(applyAsNavDefault(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.applyAsNavDefaultButton)
        self.applyAsDefaultButton.setTitle("| apply as default", for: .normal)
        self.applyAsDefaultButton.addTarget(self, action: #selector(applyAsDefault(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.applyAsDefaultButton)
        self.applyAsNavDefaultButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.randomColorButton.snp.bottom).offset(8)
        }
        self.applyAsDefaultButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.applyAsNavDefaultButton)
            make.left.equalTo(self.applyAsNavDefaultButton.snp.right).offset(8)
        }

        self.pushButton.setTitle("push", for: .normal)
        self.pushButton.addTarget(self, action: #selector(push(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.pushButton)
        self.pushWithRandomColorButton.setTitle("| push with random color", for: .normal)
        self.pushWithRandomColorButton.addTarget(self, action: #selector(pushWithRandomColor(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.pushWithRandomColorButton)
        self.pushButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.applyAsNavDefaultButton.snp.bottom).offset(8)
        }
        self.pushWithRandomColorButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.pushButton)
            make.left.equalTo(self.pushButton.snp.right).offset(8)
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.viewControllers.count == 1 && self.navigationController?.viewControllers.first == self && !self.viewDidAppear_called {
            //初始化第一次显示
            let style = RNBNavigationBarStyle.systemDefault()
            self.applyStyleToView(style: style)
            self.applyStyleToNavigationBar(style: style)
        }
        if let style = self.outSettedStyle {
            self.applyStyleToView(style: style)
            self.applyStyleToNavigationBar(style: style)
            self.outSettedStyle = nil
        }
        self.title = self.navigationController?.viewControllers.firstIndex(of: self)?.description
    }

    var viewDidAppear_called:Bool = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppear_called = true
        //self.applyStyleToNavigationBar(style: self.outSettedStyle)
    }

    ///当前view设置的style
    func styleFromView() -> RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(CGFloat(self.alphaSlider.value))
        style.backgroundAlphaSetting = .setted(CGFloat(self.backAlphaSlider.value))
        style.backgroundColorSetting = .setted(self.barTintPreviewView.backgroundColor!)
        style.tintColorSetting = .setted(self.tintPreviewView.backgroundColor!)
        style.titleColorSetting = .setted(titlePreviewView.backgroundColor!)
        style.shadowViewHiddenSetting = .setted(self.shadowSwitch.isOn)
        switch self.statusBarSegment.selectedSegmentIndex {
        case 0:
            style.statusBarStyleSetting = .setted(.default)
        case 1:
            if #available(iOS 13, *) {
                style.statusBarStyleSetting = .setted(.darkContent)
            }else {
                style.statusBarStyleSetting = .setted(.default)
            }
        case 2:
            style.statusBarStyleSetting = .setted(.lightContent)
        default:
            break
        }
        return style
    }

    func applyStyleToView(style:RNBNavigationBarStyle) {
        self.alphaSlider.value = Float(style.alphaSetting.value ?? 1.0)
        self.backAlphaSlider.value = Float(style.backgroundAlphaSetting.value ?? 1.0)

        if true {
            let backgroundColor = style.backgroundColorSetting.value ?? RNBHelper.systemDefaultNavigationBarBackgroundColor
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            backgroundColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            self.backgroundColorSlider.value = Float(hue)
            self.backgroundColorAlphaSlider.value = Float(alpha)
            self.barTintPreviewView.backgroundColor = backgroundColor
        }
        if true {
            let tintColor = style.tintColorSetting.value ?? RNBHelper.systemDefaultNavigationBarTintColor
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            tintColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            self.tintColorSlider.value = Float(hue)
            self.tintAlphaSlider.value = Float(alpha)
            self.tintPreviewView.backgroundColor = tintColor
        }
        if true {
            let titleColor = style.titleColorSetting.value ?? RNBHelper.systemDefaultNavigationBarTitleColor
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            titleColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            self.titleColorSlider.value = Float(hue)
            self.titleAlphaSlider.value = Float(alpha)
            self.titlePreviewView.backgroundColor = titleColor
        }
        self.shadowSwitch.isOn = style.shadowViewHiddenSetting.value ?? RNBHelper.systemDefaultNavigationBarShadowViewHidden
        switch style.statusBarStyleSetting.value ?? RNBHelper.systemDefaultStatusBarStyle {
        case .default:
            self.statusBarSegment.selectedSegmentIndex = 0
        case .darkContent:
            self.statusBarSegment.selectedSegmentIndex = 1
        case .lightContent:
            self.statusBarSegment.selectedSegmentIndex = 2
        @unknown default:
            fatalError()
        }
    }

    func applyStyleToNavigationBar(style:RNBNavigationBarStyle) {
        self.rnb_setNavigationBarAlpha(style.alphaSetting.value!)
        self.rnb_setNavigationBarBackgroundAlpha(style.backgroundAlphaSetting.value!)
        self.rnb_setNavigationBarBackgroundColor(style.backgroundColorSetting.value!)
        self.rnb_setNavigationBarTintColor(style.tintColorSetting.value!)
        self.rnb_setNavigationBarTitleColor(style.titleColorSetting.value!)
        self.rnb_setNavigationBarShadowViewHidden(style.shadowViewHiddenSetting.value!)
        self.rnb_setStatusBarStyle(style.statusBarStyleSetting.value!)
    }

    @IBAction func didTapDone(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    //MARK: - 参数调节Action

    @IBAction func alphaSliderAction(_ sender: Any?) {
        let value = CGFloat(self.alphaSlider.value)
        self.alphaNumLabel.text = String.init(format: "%.2f", value)
    }

    @IBAction func backAlphaAction(_ sender: Any?) {
        let value = CGFloat(self.backAlphaSlider.value)
        self.backAlphaNumLabel.text = String.init(format: "%.2f", value)
    }

    @IBAction func backgroundColorAction(_ sender: Any?) {
        let hue = CGFloat(self.backgroundColorSlider.value)
        let alpha = CGFloat(self.backgroundColorAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.barTintPreviewView.backgroundColor = color
    }
    @IBAction func barTintAlphaAction(_ sender: Any?) {
        let hue = CGFloat(self.backgroundColorSlider.value)
        let alpha = CGFloat(self.backgroundColorAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.barTintPreviewView.backgroundColor = color
    }

    @IBAction func tintColorAction(_ sender: Any?) {
        let hue = CGFloat(self.tintColorSlider.value)
        let alpha:CGFloat = 1.0//CGFloat(self.tintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.tintPreviewView.backgroundColor = color
    }
    @IBAction func tintAlphaAction(_ sender: Any?) {
        let hue = CGFloat(self.tintColorSlider.value)
        let alpha = CGFloat(self.tintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.tintPreviewView.backgroundColor = color
    }

    @IBAction func titleColorAction(_ sender: Any?) {
        let hue = CGFloat(self.titleColorSlider.value)
        let alpha = CGFloat(self.titleAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.titlePreviewView.backgroundColor = color
    }
    @IBAction func titleAlphaAction(_ sender: Any?) {
        let hue = CGFloat(self.titleColorSlider.value)
        let alpha = CGFloat(self.titleAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.titlePreviewView.backgroundColor = color
    }

    @IBAction func apply(_ sender: Any) {
        let style = self.styleFromView()
        self.applyStyleToNavigationBar(style: style)
    }

    @IBAction func randomColor(_ sender: Any?) {
        self.backgroundColorSlider.setValue(Float.random(in: 0...1), animated: true)
        self.backgroundColorSlider.sendActions(for: .valueChanged)
        self.backgroundColorAlphaSlider.setValue(1.0, animated: true)
        self.backgroundColorAlphaSlider.sendActions(for: .valueChanged)

        self.tintColorSlider.setValue(Float.random(in: 0...1), animated: true)
        self.tintColorSlider.sendActions(for: .valueChanged)
        self.titleColorSlider.setValue(Float.random(in: 0...1), animated: true)
        self.titleColorSlider.sendActions(for: .valueChanged)
        self.shadowSwitch.isOn = Bool.random()
        self.statusBarSegment.selectedSegmentIndex = (0...statusBarSegment.numberOfSegments).randomElement()!
    }

    @IBAction func randomColorAndApply(_ sender: Any) {
        self.randomColor(sender)
        self.apply(sender)
    }

    @IBAction func applyAsNavDefault(_ sender: Any) {

    }

    @IBAction func applyAsDefault(_ sender: Any) {
        let style = self.styleFromView()
        self.navigationController?.rnb_defaultNavigationBarAlpha = style.alphaSetting
        self.navigationController?.rnb_defaultNavigationBarBackgroundAlpha = style.backgroundAlphaSetting
        self.navigationController?.rnb_defaultNavigationBarBackgroundColor = style.backgroundColorSetting
        self.navigationController?.rnb_defaultNavigationBarTintColor = style.tintColorSetting
        self.navigationController?.rnb_defaultNavigationBarTitleColor = style.titleColorSetting
        self.navigationController?.rnb_defaultNavigationBarShadowViewHidden = style.shadowViewHiddenSetting
        self.navigationController?.rnb_defaultStatusBarStyle = style.statusBarStyleSetting
    }

    @IBAction func push(_ sender: Any?) {
        let style = self.styleFromView()
        let vc = AllTestViewController()
        vc.outSettedStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func pushWithRandomColor(_ sender: Any) {
        self.randomColor(sender)
        self.push(nil)
    }

}

