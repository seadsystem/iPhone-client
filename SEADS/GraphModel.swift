//
//  GraphModel.swift
//  SEADS
//
//  Created by Olexiy Burov on 12/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation

public protocol GraphModelDelegate : class {
    func needsToUpdateGraphWithPoints(consumption: [DataPoint],generation: [DataPoint])
}

public class GraphModel {
    private let executor = RequestExecutor()
    
    public var date: NSDate!
    
    public weak var delegate: GraphModelDelegate?
    
    private var consumptionPoints: [DataPoint]? {
        didSet {
            if self.generationPoints != nil {
                updateChart()
            }
        }
    }
    
    private var generationPoints: [DataPoint]? {
        didSet {
            if self.consumptionPoints != nil {
                updateChart()
            }
        }
    }
    
    private func updateChart() {
        delegate?.needsToUpdateGraphWithPoints(self.consumptionPoints!, generation: self.generationPoints!)
    }
    
    public func requestDataForTheDay() {
        let startOfTheDay = getStartOfTheDay()
        let endOfTheDay = getEndOfTheDay()
        let consumptionRequest = SeadsRequest(startTime: startOfTheDay, endTime: endOfTheDay, listFormat: "energy", device: "Panel3", type: "P")
        requestConsumption(consumptionRequest)
        let generationRequest = SeadsRequest(startTime: startOfTheDay, endTime: endOfTheDay, listFormat: "energy", device: "PowerS", type: "P")
        requestGeneration(generationRequest)
    }
    
    private func requestConsumption(request: SeadsRequest) {
        executor.sendRequest(request) { (points, error) -> Void in
            if let points = points {
                self.consumptionPoints = points
            }
        }
    }
    
    private func requestGeneration(request: SeadsRequest) {
        executor.sendRequest(request) { (points, error) -> Void in
            if let points = points {
                self.generationPoints = points
            }
        }
    }
    
    private func getStartOfTheDay() -> NSDate {
        let startOfTheDay = NSCalendar.currentCalendar().startOfDayForDate(self.date)
        return startOfTheDay
    }
    
    private func getEndOfTheDay() -> NSDate {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        let startOfTheDay = NSCalendar.currentCalendar().startOfDayForDate(self.date)
        let endOfTheDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfTheDay, options: NSCalendarOptions())
        return endOfTheDay!
    }
}