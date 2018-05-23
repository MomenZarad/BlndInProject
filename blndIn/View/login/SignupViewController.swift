//
//  SignupViewController.swift
//  blndIn
//
//  Created by Momen Adel Zarad on 4/10/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import SwiftyJSON
import SVProgressHUD

class SignupViewController: UIViewController , CLLocationManagerDelegate{
    
    var latitude : String = ""
    var longitude : String = ""
    
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
    
    
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpTextField: UITextField!
    @IBOutlet weak var popUpBtn: UIButton!
    
    
    //Set UserName--------------------------------------------------------------------
    let SetURL = "http://blndin.com:76/settings/set-username"
    //Prepare the attribute
    func prepareForSetUser(){
        
        let setUserName : String = popUpTextField.text!
        let tok : String = signUp.token
        var validUserName : Bool = validateIO(name : setUserName , token : tok)
        if validUserName == true
        {
            let SetUserparams:[String : String] = ["username":setUserName , "token":tok]
            SetUserNameConnection(url: SetURL, parameters: SetUserparams)
            print("\(tok)")
            print("\(signUp.token)")
        }
        else{
            print("Valid Username")
        }
    }
    //Checking if the the text field empty or not
    func validateIO(name : String , token : String) -> Bool
    {
        if name != ""
        {
            return true
        }
        else
        {
            SVProgressHUD.dismiss()
            return false
        }
    }
    //Start the Connection
    func SetUserNameConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    print("Done")
                    self.animateout()
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "SignUpPass", sender: self)
                }
                else if status == 707
                {
                    print("Username is already used")
                    SVProgressHUD.dismiss()

                }
                else{
                    print("Unvalid username")
                    SVProgressHUD.dismiss()

                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    
    //SignUp Regular User------------------------------------------------------------
    let RegularURL = "http://blndin.com:76/auth/register/regular"
    //Location Settings
    let locationManager = CLLocationManager()
    let currentLocation = CLLocation()
    
    
    func prepareForNetworking(){
        //Prepare the Attributes
        let username : String = usernameTextField.text!
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        latitude = String(currentLocation.coordinate.latitude)
        longitude = String(currentLocation.coordinate.longitude)
        var valid : Bool = validateinput(name : username , email : email , pass : password)
        if valid == true
        {
            let params:[String : String] = ["name":username , "email" : email , "password" : password , "lat":latitude , "lng":longitude ]
            createConnection(url: RegularURL, parameters: params)
        }
        else{
            print("enter name & email & password")
        }
    }
    //Checking if the the text field empty or not
    func validateinput(name : String , email : String , pass : String) -> Bool
    {
        if name != "" && email != "" && pass != ""
        {
            return true
        }
        else
        {
            SVProgressHUD.dismiss()
            return false
            
        }
    }
    //Start the Connection
    func createConnection(url : String , parameters : [String : String])
    {
        let configration = URLSessionConfiguration.default
        configration.timeoutIntervalForRequest = 1000.0
        Alamofire.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    self.parsingJSON(json: JSONResult)
                    self.animateIn()
                }
                else
                {
                    print("invalid Username or password")
                    SVProgressHUD.dismiss()

                }
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    //JSON Parsing
    
    let signUp = signUpModel()
    func parsingJSON(json:JSON)
    {
        signUp.token = json["payload"]["token"].stringValue
        SVProgressHUD.dismiss()
        print("\(signUp.token)")
    }
    //---------------------------------------------------------------------------------
    
    
    
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
        //Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
        //PopUP Customize
        popUpTextField.layer.cornerRadius = 5
        popUpView.layer.cornerRadius = 5
        //shdow
        popUpView.layer.shadowOpacity = 0
        popUpView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popUpView.layer.shadowRadius = 5
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.masksToBounds = false
        popUpBtn.layer.cornerRadius = 10
        //Shared pref
        
    }
    
    func animateIn()
    {
        self.view.addSubview(popUpView)
        popUpView.center = self.view.center
        popUpView.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    //animate when popup closed
    func animateout()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
            self.popUpView.alpha = 0
            self.popUpView.alpha = 1
        }) { (success:Bool) in
            self.popUpView.removeFromSuperview()
            
        }
    }
    
    
    //Stop Updating user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SingupBtnClicked(_ sender: Any) {
        let currentLevelKey = "token"
        //shared preferance
        let preferences = UserDefaults.standard
        preferences.set(signUp.token, forKey: currentLevelKey)
        preferences.synchronize()
        prepareForNetworking()
        SVProgressHUD.setStatus("Loading")
        animateIn()
    }
    @IBAction func SetUsernameBtn(_ sender: UIButton) {
        prepareForSetUser()
        SVProgressHUD.setStatus("Loading")
    }
}
