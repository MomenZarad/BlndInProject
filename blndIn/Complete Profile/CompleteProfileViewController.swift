//
//  CompleteProfileViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/10/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class CompleteProfileViewController: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource,UINavigationControllerDelegate , UIImagePickerControllerDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var CompleteView: UIView!
    @IBOutlet weak var DoneBtn: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    
    let gender = ["Male","Female","Other"]
    var pickerView = UIPickerView()
    
    func createGradientLayer(radius : CGFloat , shape :Bool) -> CAGradientLayer{
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //the frame that the gradient color will apply on
        //if bool is 0 => view
        if shape == false
        {gradientLayer.frame = CompleteView.bounds}
            //if bool is 1 => button
        else if shape == true
        {gradientLayer.frame = DoneBtn.bounds}
        
        //the colors
        gradientLayer.colors = [UIColor(red:0.55, green:0.85, blue:0.84, alpha:1.0).cgColor
            ,UIColor(red:0.00, green:0.80, blue:0.67, alpha:1.0).cgColor,]
        //radius
        gradientLayer.cornerRadius = radius
        //shadow
        gradientLayer.shadowOpacity = 0.15
        gradientLayer.shadowOffset = CGSize(width: 10, height: 15)
        gradientLayer.shadowRadius = 5
        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.masksToBounds = false
        //rotate
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        return gradientLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding color to complete view
        self.CompleteView.layer.insertSublayer(createGradientLayer(radius: 10, shape: false), at: 0)
        //border radious
        self.CompleteView.layer.cornerRadius = 10
        self.CompleteView.layer.masksToBounds = false
        //------------------------------------------------------------------------
        //design of rect complete button
        //------------------------------------------------------------------------
        //adding color to complete button
        self.DoneBtn.layer.insertSublayer(createGradientLayer(radius: 25, shape: true), at: 0)
        //radius
        self.DoneBtn.layer.cornerRadius = 25
        self.CompleteView.layer.masksToBounds = false
        //--------------------------------------------------------------------------------
        firstNameTextField.alpha = 0.5
        firstNameTextField.borderStyle = UITextBorderStyle.none
        firstNameTextField.layer.cornerRadius = 5
        lastNameTextField.alpha = 0.5
        lastNameTextField.borderStyle = UITextBorderStyle.none
        lastNameTextField.layer.cornerRadius = 5
        phoneTextField.alpha = 0.5
        phoneTextField.borderStyle = UITextBorderStyle.none
        phoneTextField.layer.cornerRadius = 5
        genderTextField.alpha = 0.5
        genderTextField.borderStyle = UITextBorderStyle.none
        genderTextField.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = UIColor.black
        //UIPicker Setting
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTextField.inputView = pickerView
        genderTextField.textAlignment = .center
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
        genderTextField.resignFirstResponder()
        
    }
    
    //image picker func
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profileImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller,animated: true , completion: nil)
    }
    

}
