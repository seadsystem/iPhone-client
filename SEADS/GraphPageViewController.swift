//
//  GraphPageViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 12/2/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit

public class GraphPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    private var controllers = [Int:GraphViewController]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        let gvc = self.storyboard?.instantiateViewControllerWithIdentifier(GraphViewController.identifier) as! GraphViewController
        controllers[gvc.index] = gvc
        gvc.index = 0
        self.setViewControllers([gvc], direction: .Forward, animated: false, completion: nil)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let current = viewController as? GraphViewController {
            let newIndex = current.index + 1
            if let gvc = controllers[newIndex] {
                return gvc
            } else {
                let gvc = self.storyboard?.instantiateViewControllerWithIdentifier(GraphViewController.identifier) as! GraphViewController
                gvc.index = newIndex
                return gvc
            }
        }
        return nil
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let current = viewController as? GraphViewController {
            let newIndex = current.index - 1
            if let gvc = controllers[newIndex] {
                return gvc
            } else {
                let gvc = self.storyboard?.instantiateViewControllerWithIdentifier(GraphViewController.identifier) as! GraphViewController
                gvc.index = newIndex
                return gvc
            }
        }
        return nil
    }
}
