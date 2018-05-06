//
//  letsGoMapViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/2/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import MapKit

class letsGoMapViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    
    
    @IBOutlet weak var letsGoMap: MKMapView!
    @IBOutlet weak var letsgoBtn: UIButton!
    @IBOutlet weak var selectActivityView: UIView!
    @IBOutlet weak var ActivityPickerView: UIPickerView!
    var data : [String] = ["zyad galal " , "abdullah ahmed" , "momen adel" , "zyad mahmoud" ,"zozz el 7raa2" , "zozz el ga7ed" , "el zozz el moz"]
    func selectActivityViewDesign()
    {
        selectActivityView.layer.cornerRadius = 5
        //shdow
        selectActivityView.layer.shadowOpacity = 0.4
        selectActivityView.layer.shadowOffset = CGSize(width: 5, height: 5)
        selectActivityView.layer.shadowRadius = 5
        selectActivityView.layer.shadowColor = UIColor.black.cgColor
        selectActivityView.layer.masksToBounds = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectActivityViewDesign()
        letsgoBtn.layer.cornerRadius = 10
        ActivityPickerView.dataSource = self
        ActivityPickerView.delegate = self
        letsGoMap.isUserInteractionEnabled = false 		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
