//
//  SignupViewController.swift
//  blndIn
//
//  Created by Momen Adel Zarad on 4/10/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    
  
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    //create backgroud color of gradient
    func createGradientLayer(radius : CGFloat , shape :Bool) -> CAGradientLayer{
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //the frame that the gradient color will apply on
        //if bool is 0 => view
        if shape == false
        {gradientLayer.frame = signUpView.bounds}
            //if bool is 1 => button
        else if shape == true
        {gradientLayer.frame = signUpButton.bounds}
        
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
        //design of rect login view
        //------------------------------------------------------------------------
        //adding color to login view
        self.signUpView.layer.insertSublayer(createGradientLayer(radius: 10, shape: false), at: 0)
        //border radious
        self.signUpView.layer.cornerRadius = 10
        self.signUpView.layer.masksToBounds = false
        //------------------------------------------------------------------------
        //design of rect login button
        //------------------------------------------------------------------------
        //adding color to login button
        self.signUpButton.layer.insertSublayer(createGradientLayer(radius: 25, shape: true), at: 0)
        //radius
        self.signUpButton.layer.cornerRadius = 25
        self.signUpView.layer.masksToBounds = false
        //--------------------------------------------------------------------------------
        //change text filed design
        //--------------------------------------------------------------------------
        usernameTextField.alpha = 0.5
        usernameTextField.borderStyle = UITextBorderStyle.none
        usernameTextField.layer.cornerRadius = 5
        emailTextField.alpha = 0.5
        emailTextField.borderStyle = UITextBorderStyle.none
        emailTextField.layer.cornerRadius = 5
        passwordTextField.alpha = 0.5
        passwordTextField.borderStyle = UITextBorderStyle.none
        passwordTextField.layer.cornerRadius = 5
        confirmPassTextField.alpha = 0.5
        confirmPassTextField.borderStyle = UITextBorderStyle.none
        confirmPassTextField.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SingupBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "tableView", sender: self)
    }
    
}
