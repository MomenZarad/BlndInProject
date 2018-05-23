//
//  MySquadChatViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MySquadChatViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
    
    //send Mesage Chat
    
    let sendMessageChatURL = "http://blndin.com:76/squads/chat/create"
    
    func Networking(){
        let id : String = ""
        let message : String = ""
        let token : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["squad_id":id,"message":message,"token":currentLevel]
            Connection(url: sendMessageChatURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    func Connection(url : String , parameters : [String : String])
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
                    print("Created Succsessfully")
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
    
    
    
    //--------------------------------
    
    let squadChatURL = "http://blndin.com:76/squads/chat"
    
    func prepareForChatNetworking(){
        let id : String = ""
        let token : String = ""
        let preferences = UserDefaults.standard
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)!
            let params:[String : String] = ["squad_id":id,"token":currentLevel]
            createChatConnection(url: squadChatURL, parameters: params)
            print("\(currentLevel)")
        }
        
    }
    func createChatConnection(url : String , parameters : [String : String])
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
    
    let chat = squadChatModel()
    
    func parsingJSON(json:JSON)
    {
        if let data = json["payload"]["data"].array{
            for user in data{
                chat.id = user["id"].stringValue
                chat.message = user["message"].stringValue
                chat.username = user["username"].stringValue
                chat.name = user["name"].stringValue
                chat.image = user["image"].stringValue
                chat.owned = user["owned"].stringValue
                chat.created_at = user["created_at"].stringValue
                //download image
                let url = NSURL(string: chat.image)
                let data = NSData(contentsOf: url as! URL)
                let img = UIImage(data: data as! Data)
                avatararr.append(img!)
                usernamearr.append(chat.name)
                arr.append(chat.message)
                
            }
            squadChatTableView.reloadData()
        }
    }
    
    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var squadChatTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendNewMessageField: UITextField!
    
    var arr = [String]()
    var recieverbody = [String]()
    var usernamearr = [String]()
    var avatararr = [UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendNewMessageField.delegate = self
        squadChatTableView.delegate = self
        squadChatTableView.dataSource = self
        viewWillAppear(true)
        //Btn customization
        sendBtn.layer.cornerRadius = 15
        squadChatTableView.separatorStyle = .none
        sendNewMessageField.autocorrectionType = .no
        prepareForChatNetworking()
        //customize keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        squadChatTableView.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        insertNewMessage()
        Networking()
    }
    //controlling the view
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightconstraint.constant = 252
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightconstraint.constant = 36
            self.view.layoutIfNeeded()
        }
    }
    
    //def func tableviewTapped
    
    @objc func tableViewTapped() {
        sendNewMessageField.endEditing(true)
    }
    
    //Add New Message using textField
    func insertNewMessage(){
        arr.append(sendNewMessageField.text!)
        let indexPath = IndexPath(row: arr.count-1,section: 0)
        squadChatTableView.beginUpdates()
        squadChatTableView.insertRows(at: [indexPath], with: .fade)
        squadChatTableView.endUpdates()
        sendNewMessageField.text = ""
    }
    
    //resize the height
    override func viewWillAppear(_ animated: Bool) {
        squadChatTableView.estimatedRowHeight = 100
        squadChatTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //Cells in tableView Properties
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // with if statment we choose the cell we will use with the api
        
        //Sender Cell
        let cell1 = squadChatTableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! senderTableViewCell
        let cell = squadChatTableView.dequeueReusableCell(withIdentifier: "senderMessage", for: indexPath) as! senderTableViewCell
        if chat.owned == "1"
        {
            cell.senderMessagebody.text = arr[indexPath.row]
            return cell
        }
        else if chat.owned == "0"{
            //Reciever Cell
            let recieverCell = squadChatTableView.dequeueReusableCell(withIdentifier: "RecieverMessage", for: indexPath) as! RecieverTableViewCell
            recieverCell.RecieverMessageBody.text = arr[indexPath.row]
            recieverCell.UsernameLabel.text = usernamearr[indexPath.row]
            recieverCell.RecieverAvatar.image = avatararr[indexPath.row]
            return recieverCell
        }
        else{
            return cell1
        }
        
    }
    
}
