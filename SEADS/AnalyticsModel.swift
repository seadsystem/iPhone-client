//
//  AnalyticsModel.swift
//  SEADS
//
//  Created by Olexiy Burov on 10/29/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation

public typealias DataResponse = ([DataPoint]) -> Void

public class AnalyticsModel {
//    private let localDataPath = "//Users//Alex//Documents//Programming//SEADS//SEADS//data.csv"
//    
//    public func readDataIntoArray() -> [String] {
//        var dataArray: [String]!
//        
//        do {
//            let file = try String(contentsOfFile: localDataPath)
//            dataArray = file.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
//        } catch {
//            print("Error reading file")
//        }
//        
//        return dataArray
//    }
//    
//    public func fetchData(onCompletion: DataResponse) {
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { () -> Void in
//            let data = self.readDataIntoArray()
//            var dataPoints = [DataPoint]()
//            
//            for var i = 2; i < data.count; i++ {
//                if data[i] != "" {
//                    let dataPoint = DataPoint(csv: data[i])
//                    dataPoints.append(dataPoint)
//                }
//            }
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                onCompletion(dataPoints)
//            })
//        }
//    }
//    
//    public func getData() -> [DataPoint] {
//        let data = readDataIntoArray()
//        var dataPoints = [DataPoint]()
//        
//        for var i = 2; i < data.count; i++ {
//            if data[i] != "" {
//                let dataPoint = DataPoint(csv: data[i])
//                dataPoints.append(dataPoint)
//            }
//        }
//        
//        return dataPoints
//    }
}