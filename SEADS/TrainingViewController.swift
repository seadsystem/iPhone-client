//
//  TrainingViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var model = TrainingEventsModel()
    
    private var pickerModel = PickerViewModel()
    
    private var expanded = false
    
    var options: [String:UIImage]!
    
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        let event1 = Event(time: "9:44 PM October 15th")
        event1.options = ["Option 1","Option 2","Option 3"]
        let event2 = Event(time: "7:32 AM October 15th")
        event2.options = ["Option 4","Option 5","Option 6"]
        let event3 = Event(time: "8:44 AM October 15th")
        event3.options = ["Option 7","Option 8","Option 9"]
        let event4 = Event(time: "11:44 AM October 14th")
        event4.options = ["Option 10","Option 11","Option 12"]
        
        model.events = [event1,event2,event3,event4]
        tableView.dataSource = model
        tableView.delegate = self
        pickerView.delegate = pickerModel
        pickerView.dataSource = pickerModel
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let event = model.events?[indexPath.row]
        pickerModel.options = event?.options
        updatePickerData()
        if !expanded {
            showPanel()
        }
    }
    
    private func updatePickerData() {
        pickerView.reloadComponent(0)
    }
    
    private func showPanel() {
        let constant = self.pickerViewContainer.bounds.height

        UIView.animateWithDuration(0.4) { () -> Void in
            self.constraint.constant = constant
            self.view.layoutIfNeeded()
        }
        
        expanded = true
    }
    
    private func hidePanel() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.constraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        expanded = false
    }
    
    // MARK: PickerViewContainerActions
    @IBAction func doneClicked(sender: UIBarButtonItem) {
        hidePanel()
    }
    
    @IBAction func cancelClicked(sender: UIBarButtonItem) {
        hidePanel()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        
    }
}
