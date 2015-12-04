//
//  RequestExecutor.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/30/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation
import SwiftyJSON
// db.sead.systems:8080/466419817?start_time=1445756400&end_time=1445842800&list_format=energy&granularity=60&device=Panel1&type=P
public class RequestExecutor {
    
    public typealias ServerResponse = ([DataPoint]?,NSError?) -> Void
    
    private var requestToServer: NSMutableURLRequest!
    
    
    public func sendRequest(request: SeadsRequest, onCompletion: ServerResponse?) {
        configureRequest(request)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(requestToServer, completionHandler: {data, response, error -> Void in
            if data != nil {
//                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                let points = self.createPointsFromData(data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    onCompletion?(points,nil)
                })
            }
        })
        task.resume()
    }
    
    private func createPointsFromData(data:NSData) -> [DataPoint] {
        let json = JSON(data:data)
        var dataPoints = [DataPoint]()
        for (index,subJson):(String, JSON) in json["data"] {
            let time = subJson["time"].stringValue
            let value = subJson["energy"].doubleValue
            let dataPoint = DataPoint(value: value, timestamp: time)
            dataPoints.append(dataPoint)
        }
        return dataPoints
    }
    
    private func configureRequest(request: SeadsRequest) {
        let startTime = Int(request.startTime.timeIntervalSince1970)
        let endTime = Int(request.endTime.timeIntervalSince1970)
        let urlString = "http://db.sead.systems:8080/466419817?start_time=\(startTime)&end_time=\(endTime)&list_format=\(request.listFormat)&granularity=\(request.granuality)&device=\(request.device)&type=\(request.type)"
        let url = NSURL(string: urlString)
        print("Sent request to URL: \(urlString)")
        requestToServer = NSMutableURLRequest(URL: url!)
        requestToServer.HTTPMethod = "GET"
    }
}