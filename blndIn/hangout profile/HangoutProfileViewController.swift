//
//  HangoutProfileViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/28/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class HangoutProfileViewController: ButtonBarPagerTabStripViewController {
    let greenInspireColor = UIColor(red:0.55, green:0.85, blue:0.84, alpha:1.0)
    func TabBarDesign(){
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = greenInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 17)
        settings.style.selectedBarHeight = 5.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = greenInspireColor
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.greenInspireColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         TabBarDesign()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let details = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "det")
        let posts = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Posts")
        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chat")
        return [details, posts,chat]
    }

}
