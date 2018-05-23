//
//  letsGoMapViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/2/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import SVProgressHUD

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}
class letsGoMapViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , CLLocationManagerDelegate, GMSMapViewDelegate , UICollectionViewDataSource , UICollectionViewDelegate , UITextFieldDelegate , UITextViewDelegate{
    
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    @IBAction func popupHangBtn(_ sender: Any) {
        invitedFriends.append(currentUser)
        myMapView.isUserInteractionEnabled = true
        if sendinvititionsView.isHidden == true
        {
            sendinvititionsView.isHidden = false
            
            myMapView.addSubview(sendinvititionsView)
            sendinvititionsView.translatesAutoresizingMaskIntoConstraints = false
            sendinvititionsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            sendinvititionsView.widthAnchor.constraint(equalToConstant: 370).isActive = true
            sendinvititionsView.heightAnchor.constraint(equalToConstant: 185).isActive = true
            sendinvititionsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        }
        invitationsCollectionView.reloadData()
        print(currentUser.name)
        animateout(vieww: popupView)
        
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func letsgoBtnClicked(_ sender: Any) {
        selectActivityView.isHidden = true
        myMapView.isUserInteractionEnabled = true
        SVProgressHUD.setStatus("Loading")
    let params : [String : String] = ["token" :currentLevel , "lat" : "11.115" ,"lng": "11.11"]
        createUsersConnection(url: usersURL, parameters: params)
    }
    
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var hangBtn: UIButton!
    @IBOutlet weak var popupUsername: UILabel!
    
    @IBOutlet var publicMessageView: UIView!
    @IBOutlet weak var setTitle: UITextField!
    @IBOutlet weak var setMessage: UITextView!
    @IBOutlet weak var locationsPicker: UIPickerView!
    
    @IBOutlet weak var createHangoutBtn: UIButton!
    @IBAction func createHangoutBtnClicked(_ sender: Any) {
        animateout(vieww: publicMessageView)
        let title = setTitle.text
        let activity_id = activitiesIds[ActivityPickerView.selectedRow(inComponent: 0)]
        print(ActivityPickerView.selectedRow(inComponent: 0))
        let sub_activity = subActivitiy.text
        var uid = [String]()
        for var i in (0..<invitedFriends.count)
        {
            uid.append(invitedFriends[i].uuid)
        }
       
        func json(from object:Any) -> String? {
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
                return nil
            }
            return String(data: data, encoding: String.Encoding.utf8)
        }
        let message = setMessage.text
        let address = "Bremer"
        let lat = "31.1293"
        let lng = "31.3580"
        let params : [String : String] = ["token" :currentLevel,"title":title! ,"activity_id":String(activity_id) ,"sub_activity":sub_activity!,"users":json(from: uid)!,"message":message! , "address":address , "lat":lat ,"lng" : lng]
        createhangoutConnection(url: createhangoutURL, parameters: params)
    }
    let createhangoutURL = "http://blndin.com:76/hangouts/create"
    func createhangoutConnection(url : String , parameters : [String : String])
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
                    self.parsingCreateHangoutJSON(json: JSONResult)
                }
                else
                {
                    print("invalid Username or password")
                }
                
                break
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
    //object from hangout status model
    let statusModel = HangousStatusModel()
    var params = [String : String]()
    let checkStatusURL = "http://blndin.com:76/hangouts/status"
    func parsingCreateHangoutJSON(json:JSON)
    {
        let hangout_id = json["payload"]["hangout_id"].stringValue
        params = ["token" : currentLevel , "hangout_id" : hangout_id] as! [String : String]
        statusModel.hangout_id = json["payload"]["hangout_id"].int!
        scheduledTimerWithTimeInterval()
        
    }
    var timer = Timer()
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.Connecting), userInfo: nil, repeats: true)
    }

    @objc func Connecting(){
        
        Alamofire.request(checkStatusURL, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let JSONResult : JSON = JSON(response.result.value!)
                let status = JSONResult["status"].int
                print(status)
                if status == 200
                {
                    self.parsingHangoutStatusJSON(json: JSONResult)
                }
                else
                {
                    print("invalid Username or password")
                }
                
                break
            case .failure(let error):
                
                print(error)
                
    }
        }
    }
            func parsingHangoutStatusJSON(json:JSON)
            {
                var Status  = json["payload"]["status"].stringValue
                
                if Status == "1"
                {
                    timer.invalidate()
                    let currentLevelKey = "hangid"
                    //shared preferance
                    let preferences = UserDefaults.standard
                    preferences.set(statusModel.hangout_id, forKey: currentLevelKey)
                    preferences.synchronize()
                    performSegue(withIdentifier: "CorrectStatus", sender: self)
                }
            }
    @IBOutlet weak var subActivitiy: UITextView!
    @IBOutlet weak var sendInvititionBtn: UIButton!
    @IBOutlet weak var userinfoViewPopup: UIView!
    @IBOutlet var sendinvititionsView: UIView!
    @IBOutlet weak var invitationsCollectionView: UICollectionView!
    
    @IBAction func sendInvitationsBtnClicked(_ sender: Any) {
        sendinvititionsView.isHidden = true
        animateIn(vieww: publicMessageView)
    }
    
    @IBOutlet weak var letsgoBtn: UIButton!
    @IBOutlet weak var selectActivityView: UIView!
    @IBOutlet weak var ActivityPickerView: UIPickerView!
    
    
    
    var currentLevel :String = ""
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
    func popupViewDesign(){
        popupView.layer.cornerRadius = 5
        //shdow
        popupView.layer.shadowOpacity = 0.4
        popupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        popupView.layer.shadowRadius = 5
        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.masksToBounds = false
        profileBtn.layer.cornerRadius = 10
        hangBtn.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //invitations view
        sendinvititionsView.isHidden = true
        invitationsCollectionView.dataSource = self
        invitationsCollectionView.dataSource = self
        //-------------get token to check activities
        let preferences = UserDefaults.standard
        
        let currentLevelKey = "token"
        if preferences.object(forKey: currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            currentLevel = preferences.string(forKey: currentLevelKey)!
            SVProgressHUD.show(withStatus: "Loading")
            let params : [String : String] = ["token" : currentLevel]
            createActivityConnection(url: ActivityURL, parameters: params)
        }
        selectActivityViewDesign()
        letsgoBtn.layer.cornerRadius = 10
        ActivityPickerView.dataSource = self
        ActivityPickerView.delegate = self
        
        //google map
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        myMapView.delegate=self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        setupViews()
        initGoogleMaps()
        //----------------
        view.addSubview(selectActivityView)
        selectActivityView.isUserInteractionEnabled = true
       popupViewDesign()
        
        //---------------------------
        setTitle.delegate = self
        setMessage.delegate = self
    }
    //animation when marker click func
    func animateIn(vieww : UIView)
    {
        self.view.addSubview(vieww)
        vieww.center = self.view.center
        vieww.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
        vieww.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            
            vieww.alpha = 1
            vieww.transform = CGAffineTransform.identity
            self.view.alpha = 1
        }
    }
    //animate when popup closed
    func animateout(vieww : UIView)
    {
        UIView.animate(withDuration: 0.3, animations: {
            vieww.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
            vieww.alpha = 0
            self.myMapView.alpha = 1
        }) { (success:Bool) in
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //send invitations collection view
    //array to save invited friends in
    var invitedFriends = [LetsGoNearbyModel]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitedFriends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = invitationsCollectionView.dequeueReusableCell(withReuseIdentifier: "inviteCell", for: indexPath) as! CreateHangInvitationsCollectionViewCell
        Cell.usrImg.image = invitedFriends[indexPath.row].imageURL
        Cell.usrName.text = invitedFriends[indexPath.row].name
        
        //shdow
        Cell.View.layer.shadowOpacity = 0.4
        Cell.View.layer.shadowOffset = CGSize(width: 3, height: 3)
        Cell.View.layer.cornerRadius = 5
        Cell.View.layer.shadowRadius = 10
        Cell.View.layer.shadowColor = UIColor.black.cgColor
        Cell.View.layer.masksToBounds = false
        
        sendInvititionBtn.layer.cornerRadius = 10
        return Cell
    }
    //func for picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activitiesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activitiesList[row]
    }
    //--------------------------------
    //google maps
    func setupViews() {
        view.addSubview(myMapView)
        myMapView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myMapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myMapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive=true
        
        myMapView.isUserInteractionEnabled = false
        
    }
    //init google map
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 28.7041, longitude: 77.1025, zoom: 17.0)
        self.myMapView.camera = camera
        self.myMapView.delegate = self
        self.myMapView.isMyLocationEnabled = true
    }
    
    // MARK: CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
    var latt :String=""
    var lng :String=""
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        latt = String(lat)
        lng = String(long)
        self.myMapView.animate(to: camera)
        
        //showPartyMarkers(lat: lat, long: long)
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        myMapView.isUserInteractionEnabled = false
        popupUsername.text = markerDictionary[marker]?.name
        currentUser = markerDictionary[marker]!
        animateIn(vieww: popupView)
        
        return false
    }
   
    let myMapView: GMSMapView = {
        let v=GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    //------------ NETWORKING------------------------
    //create connection to get activities
    let ActivityURL = "http://blndin.com:76/hangouts/activities"
    func createActivityConnection(url : String , parameters : [String : String])
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
                    self.parsingActivityJSON(json: JSONResult)
                }
                else
                {
                    print("invalid Username or password")
                }
                
                break
            case .failure(let error):
                
                print(error)
               
            }
        }
    }
    var activitiesList = [String]()
    var activitiesIds = [Int]()
    //parsing json for activities
    func parsingActivityJSON(json:JSON)
    {
        if let activities = json["payload"]["activities"].array {
            for activity in activities
            {
                let id = activity["id"].int
                let title = activity["title"].stringValue
                activitiesList.append(title)
                activitiesIds.append(id!)
            }
        }
        ActivityPickerView.reloadAllComponents()
        SVProgressHUD.dismiss()
    }
    // create connection to get users
    let usersURL = "http://blndin.com:76/hangouts/map/nearby"
    func createUsersConnection(url : String , parameters : [String : String])
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
                    self.parsingUsersJSON(json: JSONResult)
                }
                else
                {
                    print("invalid Username or password")
                }
                
                break
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
    //dictionary to map marker with user locations
    var markerDictionary = [GMSMarker: LetsGoNearbyModel]()
    //var to save current user info tapped
    var currentUser = LetsGoNearbyModel()
    //parsing json for users
    func parsingUsersJSON(json:JSON)
    {
        if let users = json["payload"]["users"].array {
            for user in users
            {
                let userinfo = LetsGoNearbyModel()
                userinfo.uuid = user["uuid"].stringValue
                let path = user["image"].stringValue
                let url = NSURL(string: path)
                let data = NSData(contentsOf: url! as URL)
                userinfo.imageURL = UIImage(data: data! as Data)
                userinfo.name = user["name"].stringValue
                userinfo.username = user["username"].stringValue
                userinfo.lat = user["lat"].stringValue
                userinfo.lng = user["lng"].stringValue
                let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: userinfo.imageURL!, borderColor: UIColor(red:0.00, green:0.80, blue:0.67, alpha:1.0), tag: Int(userinfo.uuid)!)
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(userinfo.lat)!, longitude: CLLocationDegrees(userinfo.lng)!)
                marker.iconView = customMarker
                marker.map = self.myMapView
                markerDictionary[marker] = userinfo
            }
        }
        ActivityPickerView.reloadAllComponents()
        print("sucess")
        SVProgressHUD.dismiss()
    }

}








