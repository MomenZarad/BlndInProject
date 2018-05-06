//
//  MyHangoutsTabs.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//
import UIKit
import XLPagerTabStrip

class MyHangoutsTabs: ButtonBarPagerTabStripViewController {
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    func barDesign()
    {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        settings.style.selectedBarHeight = 0.5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 1
        settings.style.buttonBarRightContentInset = 1
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barDesign()
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print("\(y)")
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let posts = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Posts")
        let chat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Chat")
        let details = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "det")
        return [posts, chat , details]
    }

}
