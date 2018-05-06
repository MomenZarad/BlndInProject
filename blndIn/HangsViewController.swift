//
//  HangsViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/17/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class HangsViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    

    @IBOutlet weak var HangsTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        HangsTableView.dataSource = self
        HangsTableView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    var arr = ["momen zarad","zyad galal","mostafa waleed"]
    var img = ["kappa","group","kappa"]
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Postes table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //hang cell info
        let cell = HangsTableView.dequeueReusableCell(withIdentifier: "hangCustomCell")as! HangTableViewCell
        cell.username.text = arr[indexPath.row]
        cell.userLocation.text = "Mansoura , Egypt"
        cell.createdAt.text = "15/04/2018"
        cell.hangBackground.image = UIImage(named: img[indexPath.row])
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
        
        //----------------------- view button
        cell.ViewBtn.layer.cornerRadius = 10
        return cell
    }

    @IBAction func ViewBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "hangoutProfile", sender: self)
    }
    
}
