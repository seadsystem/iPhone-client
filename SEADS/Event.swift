//
//  Event.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation

public class Event {
    public init(time: String) {
        self.timeStamp = time
    }
    
    public var timeStamp: String?
    
    public var options: [String]?
}