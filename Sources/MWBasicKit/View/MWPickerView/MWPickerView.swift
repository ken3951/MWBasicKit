//
//  PickView.swift
//  FunCityMerchant_Swift
//
//  Created by mwk_pro on 2017/12/19.
//  Copyright © 2017年 mwk_pro. All rights reserved.
//

import UIKit
import MWBasicKitCore
import SnapKit

open class MWPickerView: UIView, MWPopEnable {
    
    public class Config: NSObject {
        ///遮罩层背景色
        public var coverBGColor = UIColor.black.withAlphaComponent(0.6)
        
        ///弹窗背景色
        public var pickViewBGColor = UIColor.white
        ///弹窗高度
        public var pickViewHeight: CGFloat = 280
        ///pickView cell行高
        public var pickViewRowHeight: CGFloat = 40
        
        ///确认按钮背景色
        public var buttonBgColor = UIColor.mw_hex("009d8e")
        ///确认按钮字体
        public var buttonFont: UIFont = UIFont.systemFont(ofSize: 16)
        ///确认按钮文字颜色
        public var buttonTitleColor = UIColor.white


        ///文字内容字体
        public var textFont: UIFont = UIFont.systemFont(ofSize: 16)
        ///文字内容颜色
        public var textColor: UIColor = UIColor.mw_rgba(51, 51, 51)

    }
    
    public let config = Config()
    
    lazy var sureBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("确定", for: .normal)
        btn.addTarget(self, action: #selector(sureButtonAction), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate=self
        pickView.dataSource=self
        return pickView
    }()
    
    var selectIndexs: [Int]
    var callback: MWInCallback<[Int]>
    var maxDepth: Int
    
    public var mw_popDismissHandler: MWVoidCallback?
    
    init(maxDepth: Int, selectIndexs: [Int], callback: @escaping MWInCallback<[Int]>) {
        self.maxDepth = maxDepth
        self.selectIndexs = selectIndexs
        self.callback = callback
        super.init(frame: .zero)
        
        initUI()
        loadData()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        self.backgroundColor = config.pickViewBGColor
        
        self.addSubview(sureBtn)
        sureBtn.titleLabel?.font = config.buttonFont
        sureBtn.backgroundColor = config.buttonBgColor
        sureBtn.setTitleColor(config.buttonTitleColor, for: .normal)
        sureBtn.contentEdgeInsets = .init(top: 8, left: 10, bottom: 8, right: 10)
        
        self.addSubview(pickerView)
        pickerView.backgroundColor = config.pickViewBGColor

        sureBtn.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
        }

        pickerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(sureBtn.snp.bottom).offset(10)
            make.height.equalTo(config.pickViewHeight)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func loadData() {
        pickerView.reloadAllComponents()
        
        selectIndexs.enumerated().forEach { component, row in
            pickerView.selectRow(row, inComponent: component, animated: false)
        }
    }
    
    func getItemTitle(inComponent component: Int, row: Int) -> String {
        fatalError("getItemTitle has not been implemented")
    }
    
    func numberOfRowsInComponent(_ component: Int) -> Int {
        fatalError("numberOfRowsInComponent has not been implemented")
    }
    
    func didSelectPickerRow(_ row: Int, inComponent component: Int) {
        
    }
    
    //MARK: --Action
    @objc func sureButtonAction() {
        var selectIndexs: [Int] = []
        for i in 0..<maxDepth {
            let index = pickerView.selectedRow(inComponent: i)
            selectIndexs.append(index)
        }
        self.callback(selectIndexs)
        self.mw_popDismissHandler?()
    }

}

//MARK: --UIPickerViewDelegate,UIPickerViewDataSource
extension MWPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return maxDepth
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent(component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let width = self.pickerView(pickerView, widthForComponent: component)
        let rowHeight = self.pickerView(pickerView, rowHeightForComponent: component)
        
        var label : UILabel
        if view != nil && view is UILabel {
            label = view as! UILabel
        }else{
            label = UILabel()
        }
        label.textAlignment = .center
        
        label.text = getItemTitle(inComponent: component, row: row)
        label.font = config.textFont
        label.textColor = config.textColor
        label.backgroundColor = config.pickViewBGColor
        label.frame = CGRect(x: 0, y: 0, width: width, height: rowHeight)
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let column: CGFloat = CGFloat(maxDepth)
        if column == 0 {
            return self.mw_width - 30
        }
        return CGFloat(Int((self.mw_width - 30 - (column - 1) * 5.0)/column))
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return config.pickViewRowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.didSelectPickerRow(row, inComponent: component)
    }
}
