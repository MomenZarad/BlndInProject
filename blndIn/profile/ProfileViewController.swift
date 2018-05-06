//
//  ProfileViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/30/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var profilePostsTableview: UITableView!
    //segment control
    @IBOutlet weak var profileView: UIView!
    let buttonBar = UIView()
    let segmentedControl = UISegmentedControl()
    var segmentIndex : Int = 0
    //------------------
    func SegmentControl()
    {
        // Add segments
        self.segmentedControl.insertSegment(withTitle: "Posts", at: 0, animated: true)
        self.segmentedControl.insertSegment(withTitle: "Bio", at: 1, animated: true)
        // First segment is selected by default
        self.segmentedControl.selectedSegmentIndex = 0
        
        // This needs to be false since we are using auto layout constraints
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the segmented control to the container view
        self.profileView.addSubview(self.segmentedControl)
        
        // Constrain the segmented control to the top of the container view
        self.segmentedControl.topAnchor.constraint(equalTo:  profileView.topAnchor).isActive = true
        // Constrain the segmented control width to be equal to the container view width
        self.segmentedControl.widthAnchor.constraint(equalTo:  profileView.widthAnchor).isActive = true
        // Constraining the height of the segmented control to an arbitrarily chosen value
        self.segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //clear backgroud color
        self.segmentedControl.backgroundColor = .clear
        self.segmentedControl.tintColor = .clear
        //change color
        self.segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 20),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        self.segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "DINCondensed-Bold", size: 20),
            NSAttributedStringKey.foregroundColor: UIColor(red:0.55, green:0.85, blue:0.84, alpha:1.0)
            ], for: .selected)
        
        
        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red:0.55, green:0.85, blue:0.84, alpha:1.0)
        profileView.addSubview(buttonBar)
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: self.segmentedControl.widthAnchor, multiplier: 1 / CGFloat(self.segmentedControl.numberOfSegments)).isActive = true
        
        //animation
        self.segmentedControl.addTarget(responds, action: #selector(segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
        segmentIndex = segmentedControl.selectedSegmentIndex
        //to do when segment control clicked
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SegmentControl()
        profilePostsTableview.dataSource = self
        profilePostsTableview.delegate = self
        
        // Do any additional setup after loading the view.
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
        return 404
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = profilePostsTableview.dequeueReusableCell(withIdentifier: "customCell") as! ProPostsTableViewCell
      /*  cell.username.text = "Zyad Galal"
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
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;*/
        return cell
        
    }
}


