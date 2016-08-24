//
//  ViewController.swift
//  CoachTest
//
//  Created by Emily Lien on 8/23/16.
//  Copyright © 2016 EmilyLien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonPressed(sender: UIButton) {
        let coachmarksVC = CoachmarksPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        presentViewController(coachmarksVC, animated: true, completion: nil)
    }
}

