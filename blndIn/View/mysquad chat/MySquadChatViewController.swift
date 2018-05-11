//
//  MySquadChatViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class MySquadChatViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {

    @IBOutlet weak var heightconstraint: NSLayoutConstraint!
    @IBOutlet weak var squadChatTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendNewMessageField: UITextField!
    
    var arr = ["Wazzzzzzzzzzzzzzzzzzzzzzzup","How are you,bro ?!"]
    var usernamearr = ["Momen Zarad","Momen Zarad"]
    var avatararr = ["profile","profile"]
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
        let cell = squadChatTableView.dequeueReusableCell(withIdentifier: "senderMessage", for: indexPath) as! senderTableViewCell
        cell.senderMessagebody.text = arr[indexPath.row]
        //------------------------------------------------
        //Reciever Cell
        let recieverCell = squadChatTableView.dequeueReusableCell(withIdentifier: "RecieverMessage", for: indexPath) as! RecieverTableViewCell
        recieverCell.RecieverMessageBody.text = arr[indexPath.row]
        recieverCell.UsernameLabel.text = usernamearr[indexPath.row]
        recieverCell.RecieverAvatar.image = UIImage(named: avatararr[indexPath.row])
        
        
        return cell
        
    }
    
}
