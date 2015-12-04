//
//  MenuOptionsViewController.swift
//  SEADS
//
//  Created by Olexiy Burov on 10/29/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import UIKit

class MenuOptionsViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for button in buttons {
            let radius = button.frame.height / 2
            button.layer.cornerRadius = radius
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
