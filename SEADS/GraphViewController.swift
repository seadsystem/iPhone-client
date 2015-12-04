//
//  GraphViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 12/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, GraphModelDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    public var model: GraphModel = GraphModel()
    
    public static let identifier = "GraphViewController"
    
    public var index = 0 {
        didSet {
            let now = NSDate()
            let day = 24.0*60.0*60.0
            let newTime = now.dateByAddingTimeInterval(day * Double(index))
            model.date = newTime
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        setup()
        model.requestDataForTheDay()
    }
    
    private func setup() {
        lineChartView.descriptionText = ""
        lineChartView.noDataTextDescription = "You need to provide data for the chart."
        
        lineChartView.dragEnabled = true;
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = true;
        lineChartView.drawGridBackgroundEnabled = false;
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10.0, label: "Index 10")
        llXAxis.lineWidth = 4.0;
        //        llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
        llXAxis.lineDashLengths = [10,10,0]
        llXAxis.labelPosition = ChartLimitLine.ChartLimitLabelPosition.RightBottom;
        llXAxis.valueFont = UIFont.systemFontOfSize(10)
        
        
        let leftAxis = lineChartView.leftAxis;
        leftAxis.removeAllLimitLines()
        //        leftAxis.addLimitLine(ll1)
        //        leftAxis.addLimitLine(ll2)
        leftAxis.customAxisMax = 5.0;
        leftAxis.customAxisMin = 0.0;
        leftAxis.startAtZeroEnabled = true;
        //        leftAxis.gridLineDashLengths = [0.5,0.5]
        leftAxis.drawLimitLinesBehindDataEnabled = true;
        
        lineChartView.rightAxis.enabled = true;
        
        lineChartView.viewPortHandler.setMaximumScaleX(300.0)
        lineChartView.viewPortHandler.setMaximumScaleY(300.0)
        
        
        lineChartView.legend.form = ChartLegend.ChartLegendForm.Line;
    }

 
    func needsToUpdateGraphWithPoints(consumption: [DataPoint], generation: [DataPoint]) {
        lineChartView.hidden = false
        populateChart(consumption, generationPoints: generation)
        spinner.stopAnimating()
    }
    
    private func populateChart(consuptionPoints: [DataPoint], generationPoints: [DataPoint]) {
        var yValuesCons = [ChartDataEntry]()
        var yValuesGen = [ChartDataEntry]()
        var xValues = [String]()
        
        
        for var i = consuptionPoints.count-1; i > 0; i-- {
            let point = consuptionPoints[i]
            if let value = point.value, var time = point.timeStamp {
//                medianConsumption += value
                let index = yValuesCons.count
                yValuesCons.append(ChartDataEntry(value: value, xIndex: index))
                xValues.append(time)
            }
        }
        
        for var i = generationPoints.count-1; i > 0; i-- {
            let point = generationPoints[i]
            if let value = point.value, var time = point.timeStamp {
//                medianGeneration += value
                let index = yValuesGen.count
                yValuesGen.append(ChartDataEntry(value: value, xIndex: index))
            }
        }
        
        let seconds = Double(consuptionPoints.count)
        let hours = seconds / 3600.0
//        medianConsumption /= seconds
//        medianGeneration /= seconds
        
//        let consumed = medianConsumption*hours*(-1)
//        let generated = medianGeneration*hours
        
//        print("Median consumption: \(medianConsumption), generation: \(medianGeneration) over \(seconds) seconds ~ \(hours) hours")
//        print("Consumed kW: \(medianConsumption*hours*(-1))")
//        print("Generated kW: \(medianGeneration*hours)")
        
//        updateTotalLabel(consumed, generated: generated)
        
        let consumptionDataSet = LineChartDataSet(yVals: yValuesCons, label: "Consumption")
        consumptionDataSet.setColor(UIColor.redColor())
        consumptionDataSet.lineWidth = 1.0
        consumptionDataSet.drawCirclesEnabled = false
        consumptionDataSet.drawValuesEnabled = false
        consumptionDataSet.fillColor = UIColor.redColor()
        consumptionDataSet.fillAlpha = 0.5
        consumptionDataSet.drawFilledEnabled = true
        
        
        let generationDataSet = LineChartDataSet(yVals: yValuesGen, label: "Generation")
        generationDataSet.setColor(UIColor.greenColor())
        generationDataSet.lineWidth = 1.0
        generationDataSet.drawCirclesEnabled = false
        generationDataSet.drawValuesEnabled = false
        generationDataSet.cubicIntensity = 0.5
        generationDataSet.fillColor = UIColor.greenColor()
        generationDataSet.fillAlpha = 0.5
        generationDataSet.drawFilledEnabled = true
        
        let data = LineChartData(xVals: xValues, dataSets: [generationDataSet,consumptionDataSet])
        
        
        lineChartView.data = data
    }
}
