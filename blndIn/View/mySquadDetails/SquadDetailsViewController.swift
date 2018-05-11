//
//  SquadDetailsViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class SquadDetailsViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource{
   
    

    var imagearr = ["profile","profile","profile","profile","profile","profile","profile","profile"]
    var usernamearr = ["momen zarad just joined the squad","zyad galal just joined the squad","mostafa waleed just joined the squad","momen zarad just joined the squad","zyad galal just joined the squad","mostafa waleed just joined the squad","Omar ElRayes just joined the squad","Omar ElRayes just joined the squad"]
    var timearr = ["1 hours ago","1 hours ago","1 hours ago","2 hours ago","3 hours ago","4 hours ago","5 hours ago","7 years ago"]
    
    let imageView = UIImageView()
    
    @IBOutlet weak var squadDetailsViewController: UITableView!
    @IBOutlet weak var MembersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squadDetailsViewController.dataSource = self
        squadDetailsViewController.delegate = self
        MembersCollectionView.delegate = self
        MembersCollectionView.dataSource = self
        setupImageView()
        //to make a space above the table view
        squadDetailsViewController.contentInset = UIEdgeInsets(top: 275, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Image setup func
    func setupImageView() {
        view.addSubview(imageView)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: 275)
        imageView.frame = rect
        imageView.image = UIImage(named: "kappa")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 250 - (scrollView.contentOffset.y + 200)
        let high = max(0, y)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: high)
        imageView.frame = rect
    }
    
    
    //collection view def
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagearr.count
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MembersCollectionView.dequeueReusableCell(withReuseIdentifier: "MembersCell", for: indexPath) as! MembersCollectionViewCell
          cell.memberImage.image = UIImage(named: imagearr[indexPath.row])
          cell.memberImage.layer.cornerRadius = 25
        return cell
    }
    //table view def
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernamearr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
        Cell.userAvatar.image = UIImage(named: imagearr[indexPath.row])
        Cell.timeLabel.text = timearr[indexPath.row]
        Cell.statusImage.image = UIImage(named: "status")
        Cell.usernameLabel.text = usernamearr[indexPath.row]
        Cell.usernameLabel.adjustsFontSizeToFitWidth = true
        return Cell
    }
    

}
