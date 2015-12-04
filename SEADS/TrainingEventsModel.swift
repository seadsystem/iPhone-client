//
//  TrainingRequestsModel.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation
import UIKit

class TrainingEventsModel: NSObject, UITableViewDataSource {
    public var events: [Event]?
    
    private let identifier = "EventCell"
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if events != nil {
//            return events!.count
//        } else {
//            return 0
//        }
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EventCell
        
        cell.event = events?[indexPath.row]
        
        return cell
    }
    
    deinit {
        print("Deinit")
    }
}