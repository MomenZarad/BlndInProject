//
//  letsGoMapViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 5/2/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import GoogleMaps
struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}
class letsGoMapViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , CLLocationManagerDelegate, GMSMapViewDelegate{
    
    let currentLocationMarker = GMSMarker()
    var locationManager = CLLocationManager()
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    @IBAction func popupHangBtn(_ sender: Any) {
        if sendInvitationsView.isHidden == true
        {
            sendInvitationsView.isHidden = false
        }
        FriendsInvited.reloadData()
        animateout()
        
       
    }
    @IBAction func letsgoBtnClicked(_ sender: Any) {
        selectActivityView.isHidden = true
        myMapView.isUserInteractionEnabled = true
    }
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var hangBtn: UIButton!
    
    @IBOutlet weak var letsgoBtn: UIButton!
    @IBOutlet weak var selectActivityView: UIView!
    @IBOutlet weak var ActivityPickerView: UIPickerView!
    
    @IBOutlet var sendInvitationsView: UIView!
    @IBOutlet weak var FriendsInvited: UICollectionView!
    var data : [String] = ["zyad galal " , "abdullah ahmed" , "momen adel" , "zyad mahmoud" ,"zozz el 7raa2" , "zozz el ga7ed" , "el zozz el moz"]
    let previewDemoData = [(title: "The Polar Junction", img:UIImage(named: "kappa") , price: 10), (title: "The Nifty Lounge", img: UIImage(named: "kappa"), price: 8), (title: "The Lunar Petal", img: UIImage(named: "kappa"), price: 12)]
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
        //send invitation view
        sendInvitationsView.isHidden = true
        
    }
    //animation when marker click func
    func animateIn()
    {
        self.view.addSubview(popupView)
        popupView.center = self.view.center
        popupView.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
        popupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
            self.myMapView.alpha = 0.7
        }
    }
    //animate when popup closed
    func animateout()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.transform = CGAffineTransform.init(scaleX:1.3 , y:1.3)
            self.popupView.alpha = 0
            self.myMapView.alpha = 1
        }) { (success:Bool) in
            self.popupView.removeFromSuperview()
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //func for picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        let location = locations.last
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
        self.myMapView.animate(to: camera)
        
        showPartyMarkers(lat: lat, long: long)
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        animateIn()
        
        return false
    }
   
    //generate 3 markers
    func showPartyMarkers(lat: Double, long: Double) {
        myMapView.clear()
        for i in 0..<3 {
            let randNum=Double(arc4random_uniform(30))/10000
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img!, borderColor: UIColor(red:0.00, green:0.80, blue:0.67, alpha:1.0), tag: i)
            marker.iconView=customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = self.myMapView
        }
    }
    let myMapView: GMSMapView = {
        let v=GMSMapView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
}
