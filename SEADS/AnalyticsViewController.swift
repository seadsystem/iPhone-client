//
//  AnalyticsViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 10/29/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit
import Charts
class CubicLineSampleFormatter : NSObject, ChartFillFormatter {
    func getFillLinePosition(dataSet dataSet: LineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10.0
    }
}

class AnalyticsViewController: UIViewController {

//    @IBOutlet weak var chartViewPlaceholder: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var medianConsumption: Double = 0
    private var medianGeneration: Double = 0
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private let model = AnalyticsModel()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let gpvc = segue.destinationViewController as? GraphPageViewController {
//            gpvc.setViewControllers([GraphViewController()], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
    
    
    private func updateTotalLabel(consumed: Double, generated: Double) {
        let info = String(format: "Total: %.1f; Consumed: %.1f; Generated: %1.f", arguments: [consumed-generated, consumed, generated])
        totalLabel.text = info
//        totalLabel.text = "TotalConsumed: \(consumed-generated); Consumed: \(consumed); Generated: \(generated)"
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}
