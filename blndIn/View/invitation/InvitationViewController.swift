//
//  InvitationViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/6/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class InvitationViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var invitationTableView: UITableView!
    let nibNamehang = UINib(nibName: "HangoutsInvititionsTableViewCell", bundle: nil)
    let nibNamesquad = UINib(nibName: "SquadsInvitationsTableViewCell", bundle: nil)
    //for segment contorl
    @IBOutlet weak var segmentInsertView: UIView!
    let buttonBar = UIView()
    let segmentedControl = UISegmentedControl()
    var segmentIndex : Int = 0
    //------------------
    func SegmentControl()
    {
        // Add segments
        self.segmentedControl.insertSegment(withTitle: "Hangouts", at: 0, animated: true)
        self.segmentedControl.insertSegment(withTitle: "Squads", at: 1, animated: true)
        // First segment is selected by default
        self.segmentedControl.selectedSegmentIndex = 0
        
        // This needs to be false since we are using auto layout constraints
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the segmented control to the container view
        self.segmentInsertView.addSubview(self.segmentedControl)
        
        // Constrain the segmented control to the top of the container view
        self.segmentedControl.topAnchor.constraint(equalTo:  segmentInsertView.topAnchor).isActive = true
        // Constrain the segmented control width to be equal to the container view width
        self.segmentedControl.widthAnchor.constraint(equalTo:  segmentInsertView.widthAnchor).isActive = true
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
        segmentInsertView.addSubview(buttonBar)
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
        invitationTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SegmentControl()
        invitationTableView.dataSource = self
        invitationTableView.delegate = self
        invitationTableView.estimatedRowHeight = 60
        invitationTableView.rowHeight = UITableViewAutomaticDimension
        invitationTableView.register(nibNamehang, forCellReuseIdentifier: "invhang")
        // invitationTableView.register(nibNamesquad, forCellReuseIdentifier: "invsquad")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = invitationTableView.dequeueReusableCell(withIdentifier: "invhang", for: indexPath) as! HangoutsInvititionsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        if segmentIndex == 0
        {
            cell.commoninit("userimage", text: "Zyad Galal invites you to join his hangout")
        }
        else if segmentIndex == 1
        {
            cell.commoninit("userimage", text: "zyad Galal invites you to join his squad , can you accept it")
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}
