//
//  ViewControllerExtension.swift
//  BeautyGallery
//
//  Created by YangRong on 15/8/12.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

extension ViewController: UIPickerViewDataSource {
    // two required methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return beauties.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return beauties[row]
    }
}