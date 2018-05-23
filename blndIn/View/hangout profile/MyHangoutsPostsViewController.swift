//
//  MyHangoutsPostsViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class MyHangoutsPostsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    //like post
    var likeURL = "http://blndin.com:76/hangouts/posts/like"
    //Prepare the attribute
    func prepareForLike(){
        
        let id : String = ""
        let tok : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["post_id":id,"token":currentLevel]
            createLikeConnection(url: likeURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    
    func createLikeConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    print("Created successfully")
                }
                else
                {
                    print("failed")
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    
    
    //unlike post
    var unlikeURL = "http://blndin.com:76/hangouts/posts/unlike"
    func prepareForUnlike(){
        
        let id : String = ""
        let tok : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["post_id":id,"token":currentLevel]
            createunLikeConnection(url: unlikeURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    
    func createunLikeConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    print("Created successfully")
                }
                else
                {
                    print("failed")
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    //comment in post
    var commentURL = "http://blndin.com:76/hangouts/posts/comments/comment"
    func prepareForComment(){
        
        let id : String = ""
        let comment : String = ""
        let tok : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["post_id":id,"comment":comment,"token":currentLevel]
            createcommentConnection(url: commentURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    
    func createcommentConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    print("Created successfully")
                }
                else
                {
                    print("failed")
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    //Posts Hangout
    let postsURL = "http://blndin.com:76/hangouts/posts"
    
    func prepareForNetworking(){
        let id : String = ""
        let token : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["hangout_id":"15","token":"$2y$10$G1Uayna.wGGnMfizciIC4.rS7LC4ad6aSEHwRwZD6PDES5RrvdSve"]
            createConnection(url: postsURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    func createConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    self.parsingJSON(json: JSONResult)
                }
                else
                {
                    print("invalid Username or password")
                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    //JSON Parsing
    
    let posts = postsModel()
    
    func parsingJSON(json:JSON)
    {
        if let data = json["payload"]["data"].array{
            for user in data{
                posts.id = user["id"].stringValue
                posts.username = user["username"].stringValue
                posts.name = user["name"].stringValue
                posts.content = user["content"].stringValue
                posts.image = user["image"].stringValue
                posts.comments = user["comments"].stringValue
                posts.likes = user["likes"].stringValue
                posts.isLiked = user["isLiked"].stringValue
            }
            
            //download image
            let url = NSURL(string: posts.image)
            let data = NSData(contentsOf: url as! URL)
            let img = UIImage(data: data as! Data)
            images.append(img!)
            users.append(posts.name)
            userdesc.append(posts.content)
            MyhangoutPosts.reloadData()
        }
        
    }
    
    
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
        prepareForNetworking()
    }
    @IBAction func likeBtn(_ sender: UIButton) {
        if let button : UIButton = sender as? UIButton
        {
            button.isSelected = !button.isSelected
            
            if(button.isSelected)
            {
                prepareForLike()
            }
            else{
                prepareForUnlike()
            }
        }
    }
    
    @IBAction func commentBtn(_ sender: UIButton) {
        prepareForComment()
    }
    var users = [String]()
    var userdesc = [String]()
    var images = [UIImage]()
    
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Download Images
        
        
        
        let cell = MyhangoutPosts.dequeueReusableCell(withIdentifier: "customCell") as! postsTableViewCell
        
        cell.username.text = users[indexPath.row]
        cell.userLocation.text = "Damietta , EGYPT"
        cell.userDescription.text = userdesc[indexPath.row]
        cell.backgroud.image = self.resizeImage(image: images[indexPath.row], targetSize: CGSize(width: 414, height: 260))
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
