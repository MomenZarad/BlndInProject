//
//  MyHangoutsChatViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class MyHangoutsChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

extension MyHangoutsChatViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chat")
}
}
