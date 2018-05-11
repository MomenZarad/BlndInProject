//
//  MyHangoutsPostsViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class MyHangoutsPostsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @IBOutlet weak var MyhangoutPosts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MyhangoutPosts.delegate = self
        MyhangoutPosts.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Postes table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = MyhangoutPosts.dequeueReusableCell(withIdentifier: "customCell") as! postsTableViewCell
        cell.username.text = "Zyad Galal"
        cell.userLocation.text = "Damietta , EGYPT"
        cell.userDescription.text = "bla blabla blabla blabla blabla blabla blabla blabla blabla blabla blabla blabla blabla blabla bla"
        cell.backgroud.image = self.resizeImage(image: UIImage(named: "group")!, targetSize: CGSize(width: 414, height: 260))
        cell.backgroud.layer.cornerRadius = 5
        cell.profileImage.image = self.resizeImage(image: UIImage(named: "profile")!, targetSize: CGSize(width: 60, height: 60))
        cell.layer.cornerRadius = 5
        cell.profileImage.layer.masksToBounds = false
        
        //shdow
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        
        cell.layoutMargins = UIEdgeInsets.zero // remove table cell separator margin
        cell.contentView.layoutMargins.left = 20
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print("++++ \(y)")
    }
}

extension MyHangoutsPostsViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Posts")
}
   
}
