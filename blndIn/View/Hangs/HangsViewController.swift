//
//  HangsViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/17/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HangsViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var HangsTableView: UITableView!
    let URL = "http://blndin.com:76/profile/hangouts"
    var currentLevel = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        HangsTableView.dataSource = self
        HangsTableView.delegate = self
        //shared preferance
        let preferences = UserDefaults.standard
        
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            currentLevel = preferences.string(forKey: currentLevelKey)!
            
        // Do any additional setup after loading the view.
        let params : [String : String] = ["token" : currentLevel]
        createConnection(url: URL, parameters: params)
        }
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
    
    let loginmodel = loginModel()
    var myHangsData  = [myHangsModel]()
    //Write the updateWeatherData method here:
    func parsingJSON(json:JSON)
    {
        if let users = json["payload"]["hangouts"].array {
            for user in users
            {
                let myHangs = myHangsModel()
                
                let path = "https://static.independent.co.uk/s3fs-public/styles/article_small/public/thumbnails/image/2017/06/09/11/group-photos-need-to-die.jpg"
                let url = NSURL(string: path)
                let data = NSData(contentsOf: url! as URL)
                myHangs.image = UIImage(data: data! as Data)
                myHangs.title = user["title"].stringValue
                myHangs.id = user["id"].stringValue
                myHangs.address = user["address"].stringValue
                myHangsData.append(myHangs)
            }
            HangsTableView.reloadData()
        }
    }
    
    //Postes table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myHangsData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //hang cell info
        let cell = HangsTableView.dequeueReusableCell(withIdentifier: "hangCustomCell")as! HangTableViewCell
        cell.username.text = myHangsData[indexPath.row].title
        cell.userLocation.text = myHangsData[indexPath.row].address
        cell.hangBackground.image = myHangsData[indexPath.row].image
        cell.layer.cornerRadius = 15
        //shdow
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        
        
        //gradient uiview background
        let gradient = CAGradientLayer()
        gradient.frame = cell.hangUIview.bounds
        gradient.colors = [UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.0).cgColor,UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.5).cgColor ,UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00).cgColor,]
        cell.hangUIview.layer.insertSublayer(gradient, at: 0)
        cell.secondUIView.layer.insertSublayer(gradient, at: 0)
        //----------------------- view button
        cell.ViewBtn.layer.cornerRadius = 10
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentLevelKey = "hangid"
        //shared preferance
        let preferences = UserDefaults.standard
        preferences.set(myHangsData[indexPath.row].id	, forKey: currentLevelKey)
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("what is going on")
        }
        
        performSegue(withIdentifier: "hangoutProfile", sender: self)
    }
    @IBAction func ViewBtnClicked(_ sender: Any) {
    }
    
}

