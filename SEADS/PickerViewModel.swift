//
//  pickerViewModel.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/6/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation
import UIKit

class PickerViewModel: NSObject, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    private static var images = {
       return 1
    }()
    
    var options: [String]!
    
//    var images: [UIImage]!
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options != nil ? options.count : 0
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let frame = CGRect(x: 0, y: 10, width: 20, height: 20)
        let option = options[row]
        let image = UIImage(named: option)
        let picture = UIImageView(image: image)
        picture.frame = frame
        
        let label = UILabel(frame: CGRect(x: 28, y: 0, width: 100, height: 40))
        label.text = option
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 148, height: 40))
        view.addSubview(picture)
        view.addSubview(label)
        return view
    }
}