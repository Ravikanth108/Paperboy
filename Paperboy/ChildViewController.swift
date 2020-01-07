//
//  ChildViewController.swift
//  PagerStripDemo
//
//  Created by Sayalee on 4/20/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BreakingNewsViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var label: UILabel!
    var childNumber: String = ""
    
    var itemInfo: IndicatorInfo = "News"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = childNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
