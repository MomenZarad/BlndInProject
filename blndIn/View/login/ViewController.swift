//
//  ViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/9/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import FirebaseAuth
import TwitterKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController ,UITextFieldDelegate {
    
    

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var twitterImgView: UIImageView!
    @IBOutlet weak var facebookImgView: UIImageView!
    
   
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
       //twitter
        twitterImgView.isUserInteractionEnabled = true
        let twittertapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TwitterimageTapped))
        twitterImgView.addGestureRecognizer(twittertapRecognizer)
        //facebook
        facebookImgView.isUserInteractionEnabled = true
        let facebooktapRecognizer = UITapGestureRecognizer(target: self, action: #selector(facebookImageTapped))
        facebookImgView.addGestureRecognizer(facebooktapRecognizer)
       //keyboard
        emailTextFiled.delegate = self
        passwordTextFiled.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //check if shared preferance has value
        let preferences = UserDefaults.standard
        
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
            print("erooooooooooooorrrororororororooro zyad galla")
        } else {
            let currentLevel = preferences.string(forKey: currentLevelKey)
            
            
            performSegue(withIdentifier: "loggedIn", sender: self)
            SVProgressHUD.show(withStatus: "Loading")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        //networking
        SVProgressHUD.show(withStatus: "Loading")
        prepareForBeginNetworking()
    
    }
    //---------------------------------------------------
    //Networking
    let URL = "http://blndin.com:76/auth/login/regular"
    func prepareForBeginNetworking()
    {
        
        let username: String = emailTextFiled.text!
        let password: String = passwordTextFiled.text!
        let validate : Bool = validateinput(name: username, password: password)
        if validate == true
        {
            let params :[String : String]=["username":username  , "password":password ]
            createConnection(url: URL, parameters: params)
        }
        else
        {
            print("enter email and password")
            SVProgressHUD.dismiss()
        }
    }
    func validateinput(name : String , password : String) -> Bool
    {
        if name != "" && password != ""
        {
            return true
        }
        else
        {
            return false
        }
    }
    func createConnection(url : String , parameters : [String : String])
    {
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
                }
                else if status == 706
                {
                    print("email is already exists")
                }
                else
                {
                    print("invalid Username or password")
                }
                SVProgressHUD.dismiss()
                
                break
            case .failure(let error):
                
                print(error)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    let loginmodel = loginModel()
    //Write the updateWeatherData method here:
    func parsingJSON(json:JSON)
    {
        loginmodel.token = json["payload"]["token"].stringValue
        print(loginmodel.token)
        let currentLevelKey = "token"
        //shared preferance
        let preferences = UserDefaults.standard
        preferences.set(loginmodel.token, forKey: currentLevelKey)
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("what is going on")
        }
       
        SVProgressHUD.showSuccess(withStatus: "Opening")
        SVProgressHUD.dismiss(withDelay: 2000)
        performSegue(withIdentifier: "loggedIn", sender: self)

    }
    //firebase auth --------------------------
    let firebaseauthURL = "http://blndin.com:76/auth/register/firebase"
    //-----------twitter-------------------------------------------------
    @objc func TwitterimageTapped(recognizer: UITapGestureRecognizer) {
        print("Image was tapped")
        let twitterBtn = TWTRLogInButton{(session, error) in
            if error != nil {
                print("twitter login error: \(String(describing: error?.localizedDescription))")
            }
            else{
                guard let token = session?.authToken else{return}
                guard let secret = session?.authTokenSecret else{return}
                let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
                Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
                    if error != nil {
                        print("twitter login error with firebase: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    //prepare to connection
                    let authid : String = (Auth.auth().currentUser?.uid)!
                    let name :String = (Auth.auth().currentUser?.displayName)!
                    let email :String = (Auth.auth().currentUser?.email)!
                    let params :[String : String] = ["auth_id": authid , "name":name , "email":email]
                    //create connection
                    self.createConnection(url: self.firebaseauthURL, parameters: params)
                    print(authid)
                    print(name)
                    print(email)
                })
            }
        }
        twitterBtn.sendActions(for: .touchUpInside)
    }
    //------------------facebook----------------------------------------------
    @objc func facebookImageTapped(recognizer: UITapGestureRecognizer) {
       let login = LoginManager()
        login.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result {
            case .success:
                let accessToken = AccessToken.current
                guard let accessTokenString = accessToken?.authenticationToken else {return}
                let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
                Auth.auth().signInAndRetrieveData(with: credentials) { (user, error) in
                    if error != nil {
                        print("facebook login error with firebase: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    //prepare to connection
                    let authid : String = (Auth.auth().currentUser?.uid)!
                    let name :String = (Auth.auth().currentUser?.displayName)!
                    let email :String = (Auth.auth().currentUser?.email)!
                    let params :[String : String] = ["auth_id": authid , "name":name , "email":email]
                    //create connection
                    self.createConnection(url: self.firebaseauthURL, parameters: params)
                    print(authid)
                    print(name)
                    print(email)
                }
            default:
                break
            }
        }
        
        
        
    }
    
}

