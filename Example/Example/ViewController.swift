//
//  ViewController.swift
//  Example
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit
import RXCNavigationBarTransition

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

class ViewController: UIViewController {

    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var alphaSlider: UISlider!

    @IBOutlet weak var backAlphaLabel: UILabel!
    @IBOutlet weak var backAlphaSlider: UISlider!

    @IBOutlet weak var barTintPreviewView: UIView!
    @IBOutlet weak var barTintColorSlider: UISlider!
    @IBOutlet weak var barTintAlphaSlider: UISlider!

    @IBOutlet weak var tintPreviewView: UIView!
    @IBOutlet weak var tintColorSlider: UISlider!
    @IBOutlet weak var tintAlphaSlider: UISlider!

    @IBOutlet weak var titlePreviewView: UIView!
    @IBOutlet weak var titleColorSlider: UISlider!
    @IBOutlet weak var titleAlphaSlider: UISlider!

    @IBOutlet weak var shadowSwitch: UISwitch!

    @IBOutlet weak var statusBarSegment: UISegmentedControl!

    var outSettedStyle:RNBNavigationBarStyle = RNBNavigationBarStyle.systemDefault()

    var scrollView:UIScrollView {return self.view as! UIScrollView}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.bounces = true
        self.scrollView.alwaysBounceVertical = true
        self.applyStyleToView(style: self.outSettedStyle)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.navigationController?.viewControllers.firstIndex(of: self)?.description
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.applyStyleToNavigationBar(style: self.outSettedStyle)
    }

    func currentStyle() -> RNBNavigationBarStyle {
        let style = RNBNavigationBarStyle()
        style.alphaSetting = .setted(CGFloat(self.alphaSlider.value))
        style.backgroundAlphaSetting = .setted(CGFloat(self.backAlphaSlider.value))
        style.barTintColorSetting = .setted(self.barTintPreviewView.backgroundColor!)
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
        self.alphaSliderAction(self.alphaSlider!)

        self.backAlphaSlider.value = Float(style.backgroundAlphaSetting.value ?? 1.0)
        self.backAlphaAction(self.backAlphaSlider!)

        if true {
            let barTintColor = style.barTintColorSetting.value ?? RNBHelper.systemDefaultNavigationBarBarTintColor
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            barTintColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            self.barTintColorSlider.value = Float(hue)
            self.barTintAlphaSlider.value = Float(alpha)
            self.barTintPreviewView.backgroundColor = barTintColor
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
        self.rnb_navigationBarAlpha = style.alphaSetting
        self.rnb_navigationBarBackgroundAlpha = style.backgroundAlphaSetting
        self.rnb_navigationBarBarTintColor = style.barTintColorSetting
        self.rnb_navigationBarTintColor = style.tintColorSetting
        self.rnb_navigationBarTitleColor = style.titleColorSetting
        self.rnb_navigationBarShadowViewHidden = style.shadowViewHiddenSetting
        self.rnb_statusBarStyle = style.statusBarStyleSetting
    }

    @IBAction func alphaSliderAction(_ sender: Any?) {
        let value = CGFloat(self.alphaSlider.value)
        self.alphaLabel.text = String.init(format: "%.2f", value)
    }
    @IBAction func alphaRandomAction(_ sender: Any?) {
        let value = Float.random(in: 0...1)
        self.alphaLabel.text = String.init(format: "%.2f", value)
        self.alphaSlider.value = value
    }

    @IBAction func backAlphaAction(_ sender: Any?) {
        let value = CGFloat(self.backAlphaSlider.value)
        self.backAlphaLabel.text = String.init(format: "%.2f", value)
    }
    @IBAction func backAlphaRandomAction(_ sender: Any?) {
        let value = Float.random(in: 0...1)
        self.backAlphaLabel.text = String.init(format: "%.2f", value)
        self.backAlphaSlider.value = value
    }

    @IBAction func barTintColorAction(_ sender: Any?) {
        let hue = CGFloat(self.barTintColorSlider.value)
        let alpha = CGFloat(self.barTintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.barTintPreviewView.backgroundColor = color
    }
    @IBAction func barTintAlphaAction(_ sender: Any?) {
        let hue = CGFloat(self.barTintColorSlider.value)
        let alpha = CGFloat(self.barTintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.barTintPreviewView.backgroundColor = color
    }
    @IBAction func barTintRandomAction(_ sender: Any?) {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0...1)
        let brightness = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        self.barTintPreviewView.backgroundColor = color
        self.barTintColorSlider.value = Float(hue)
        self.barTintAlphaSlider.value = Float(alpha)
    }

    @IBAction func tintColorAction(_ sender: Any?) {
        let hue = CGFloat(self.tintColorSlider.value)
        let alpha = CGFloat(self.tintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.tintPreviewView.backgroundColor = color
    }
    @IBAction func tintAlphaAction(_ sender: Any?) {
        let hue = CGFloat(self.tintColorSlider.value)
        let alpha = CGFloat(self.tintAlphaSlider.value)
        let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: alpha)
        self.tintPreviewView.backgroundColor = color
    }
    @IBAction func tintRandomAction(_ sender: Any?) {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0...1)
        let brightness = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        self.tintPreviewView.backgroundColor = color
        self.tintColorSlider.value = Float(hue)
        self.tintAlphaSlider.value = Float(alpha)
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
    @IBAction func titleRandomAction(_ sender: Any?) {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0...1)
        let brightness = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        self.titlePreviewView.backgroundColor = color
        self.titleColorSlider.value = Float(hue)
        self.titleAlphaSlider.value = Float(alpha)
    }

    //MARK: - 第一行

    @IBAction func apply(_ sender: Any) {
        let style = self.currentStyle()
        self.applyStyleToNavigationBar(style: style)
    }

    @IBAction func randomAll(_ sender: Any?) {
        self.alphaRandomAction(nil)
        self.backAlphaRandomAction(nil)
        self.barTintRandomAction(nil)
        self.tintRandomAction(nil)
        self.titleRandomAction(nil)
        self.shadowSwitch.isOn = Bool.random()
        self.statusBarSegment.selectedSegmentIndex = (0...statusBarSegment.numberOfSegments).randomElement()!
    }

    @IBAction func randomAllAndApply(_ sender: Any) {
        self.randomAll(nil)
        self.applyStyleToNavigationBar(style: self.currentStyle())
    }

    //MARK: - 第二行

    @IBAction func systemDefault(_ sender: Any) {
        let style = RNBNavigationBarStyle.systemDefault()
        self.applyStyleToView(style: style)
    }


    @IBAction func navDefault(_ sender: Any) {
        self.applyStyleToView(style: .notsetted())
    }

    @IBAction func setAsNavDefault(_ sender: Any) {
        let style = self.currentStyle()
        self.navigationController?.rnb_defaultNavigationBarAlpha = style.alphaSetting
        self.navigationController?.rnb_defaultNavigationBarBackgroundAlpha = style.backgroundAlphaSetting
        self.navigationController?.rnb_defaultNavigationBarBarTintColor = style.barTintColorSetting
        self.navigationController?.rnb_defaultNavigationBarTintColor = style.tintColorSetting
        self.navigationController?.rnb_defaultNavigationBarTitleColor = style.titleColorSetting
        self.navigationController?.rnb_defaultNavigationBarShadowViewHidden = style.shadowViewHiddenSetting
        self.navigationController?.rnb_defaultStatusBarStyle = style.statusBarStyleSetting
    }

    //MARK: - 第三行

    @IBAction func push(_ sender: Any?) {
        let style = self.currentStyle()
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.outSettedStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func randomPush(_ sender: Any) {
        self.randomAll(nil)
        self.push(nil)
    }

    //MARK: - 第四行

    @IBAction func presentCleanNav(_ sender: Any) {
        let vc = UITableViewController(style: .grouped)
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true, completion: nil)
    }

}

