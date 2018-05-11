//
//  NotificationViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/5/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{

   
    var imagearr = ["profile","profile","profile","profile","profile","profile","profile","profile"]
    var usernamearr = ["momen zarad just joined the squad","zyad galal just joined the squad","mostafa waleed just joined the squad","momen zarad just joined the squad","zyad galal just joined the squad","mostafa waleed just joined the squad","Omar ElRayes just joined the squad","Omar ElRayes just joined the squad"]
    var timearr = ["1 hours ago","1 hours ago","1 hours ago","2 hours ago","3 hours ago","4 hours ago","5 hours ago","7 years ago"]
    
    @IBOutlet weak var NotificationTableView: UITableView!
    override func viewDidLoad() {
        NotificationTableView.delegate = self
        NotificationTableView.dataSource = self
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //table view def
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernamearr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationTableViewCell
        Cell.notificationAvatar.image = UIImage(named: imagearr[indexPath.row])
        Cell.timeLabel.text = timearr[indexPath.row]
        Cell.statusImageView.image = UIImage(named: "status")
        Cell.usernameLabel.text = usernamearr[indexPath.row]
        Cell.usernameLabel.adjustsFontSizeToFitWidth = true
        return Cell
    }


   
}
