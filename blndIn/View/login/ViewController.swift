//
//  ViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/9/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    //create backgroud color of gradient
    func createGradientLayer(radius : CGFloat , shape :Bool) -> CAGradientLayer{
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //the frame that the gradient color will apply on
        //if bool is 0 => view
        if shape == false
        {gradientLayer.frame = loginView.bounds}
        //if bool is 1 => button
        else if shape == true
        {gradientLayer.frame = loginButton.bounds}
        
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
        self.loginView.layer.insertSublayer(createGradientLayer(radius: 10, shape: false), at: 0)
        //border radious
        self.loginView.layer.cornerRadius = 10
        self.loginView.layer.masksToBounds = false
        //------------------------------------------------------------------------
        //design of rect login button
        //------------------------------------------------------------------------
        //adding color to login button
        self.loginButton.layer.insertSublayer(createGradientLayer(radius: 25, shape: true), at: 0)
        //radius
        self.loginButton.layer.cornerRadius = 25
        self.loginView.layer.masksToBounds = false
        //--------------------------------------------------------------------------------
        //change text filed design
        //--------------------------------------------------------------------------
        emailTextFiled.alpha = 0.5
        emailTextFiled.borderStyle = UITextBorderStyle.none
        emailTextFiled.layer.cornerRadius = 5
        passwordTextFiled.alpha = 0.5
        passwordTextFiled.borderStyle = UITextBorderStyle.none
        passwordTextFiled.layer.cornerRadius = 5
        
        //----------------------------------------------------------------------------

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        //Segue to go to sign up view controller "dont have an acc"  button pressed
    
    
    @IBAction func signuplabelClicked(_ sender: Any) {
        performSegue(withIdentifier: "signupSeague", sender: self)
    }
    
    @IBAction func LogInCliked(_ sender: Any) {
        performSegue(withIdentifier: "tabLayoutseague", sender: self)
    }
}

