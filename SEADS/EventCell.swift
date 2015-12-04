//
//  EventCell.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit

public class EventCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    var deleting = false
    
    public var event: Event? {
        didSet {
            if let timeStamp = event?.timeStamp {
                label.text = "Ambigous signature: \(timeStamp)"
            }
        }
    }
}
