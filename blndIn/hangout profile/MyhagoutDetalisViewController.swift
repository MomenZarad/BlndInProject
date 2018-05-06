//
//  MyhagoutDetalisViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class MyhagoutDetalisViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var MembersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MembersCollectionView.dataSource = self
        MembersCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Profile", for: indexPath) as! ProfileCollectionViewCell
        cell.userPhoto.image = UIImage(named: "profile")
        cell.username.text = "Zyad Galal"
        
        cell.layer.borderWidth = 1.0
        
        cell.layer.cornerRadius = 5
        
        
        //shdow
        cell.layer.shadowOpacity = 0.4
        
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.clipsToBounds = false
        
        
        return cell
    }

}

extension MyhagoutDetalisViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Details")
    }
    
    
}
