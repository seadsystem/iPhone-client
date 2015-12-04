//
//  DataPoint.swift
//  SEADS
//
//  Created by Olexiy Burov on 10/29/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation

public class DataPoint {
    public var timeStamp: String?
    public var value: Double?
    
    public init (value: Double, timestamp: String) {
        self.value = value
        self.timeStamp = timestamp
    }
    
//    public init (csv: String) {
////        if csv != "" {
//            let components = csv.componentsSeparatedByString(",")
//            if let consumption = Double(components[1]), let generation = Double(components[2]) {
//                let time = components[0]
//                
//                self.timeStamp = time
//                self.consumption = consumption
//                self.generation = generation
//            }
////        }
//    }
    
    public func printDataPoint() {
        print("Data at time: \(timeStamp), value: \(value)")
    }
}
