//
//  MyhagoutDetalisViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/27/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class MyhagoutDetalisViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var MembersCollectionView: UICollectionView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var activitylbl: UILabel!
    @IBOutlet weak var locationslbl: UILabel!
    
    @IBOutlet weak var descriptionlbl: UILabel!
    var currentLevel :Int = 0
    var currentLevelT : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferences = UserDefaults.standard
        
        let currentLevelKey = "hangid"
        let currentLevelKeyT = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
             currentLevel = preferences.integer(forKey: currentLevelKey)
            }
        if preferences.object(forKey: currentLevelKeyT) == nil {
            
        }
        else{
            currentLevelT = preferences.string(forKey: currentLevelKeyT)!
        }
        MembersCollectionView.dataSource = self
        MembersCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    //---------------------------------------------------
    //Networking
    let URL = "http://blndin.com:76/hangouts/show"
    func prepareForBeginNetworking()
    {
        
            let params :[String : String]=["token":currentLevelT  , "hangout_id": String(currentLevel) ]
            createConnection(url: URL, parameters: params)
    }
    
    func createConnection(url : String , parameters : [String : String])
    {
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
                else if status == 706
                {
                    print("email is already exists")
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
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    let details = hangdetailsModel()
    //Write the updateWeatherData method here:
    func parsingJSON(json:JSON)
    {
        details.description = json["payload"]["hangout"]["title"].stringValue
        details.Activity = json["payload"]["hangout"]["activity"].stringValue
        details.location = json["payload"]["hangout"]["location"].stringValue
        let path = json["payload"]["hangout"]["image"].stringValue
        let url = NSURL(string: path)
        let data = NSData(contentsOf: url! as URL)
        details.image = UIImage(data: data! as Data)
        
        descriptionlbl.text = details.description
        activitylbl.text = details.Activity
        locationslbl.text = details.location
        coverImage.image = details.image
        
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
