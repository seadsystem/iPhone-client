//
//  TrainSelectionViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/6/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit

class TrainSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    lazy var options: [String] = {
        var opts = [String]()
        
        for var i = 1; i <= 12; i++ {
            opts.append("Option \(i)")
        }
        
        return opts
    }()
    
    var filtered = [String]()
    
    var searchActive = false
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = options.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    @IBAction func cancelClicked(sender: UIBarButtonItem) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
//    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            
//        } else {
//            
//        }
//    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? TrainCell {
            var option: String!
            if searchActive {
                option = filtered[indexPath.row]
            } else {
                option = options[indexPath.row]
            }
            cell.label.text = option
            cell.icon.image = UIImage(named: option)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TrainCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        var rightUtitlityButtons = NSMutableArray()
        rightUtitlityButtons.sw_addUtilityButtonWithColor(UIColor.redColor(), title: "Stop")
        var leftUtilityButtobs = NSMutableArray()
        leftUtilityButtobs.sw_addUtilityButtonWithColor(UIColor.greenColor(), title: "Start")
        (cell as! SWTableViewCell).leftUtilityButtons = leftUtilityButtobs as [AnyObject]
        (cell as! SWTableViewCell).rightUtilityButtons = rightUtitlityButtons as [AnyObject]

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filtered.count : options.count
    }
}
