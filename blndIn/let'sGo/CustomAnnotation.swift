//
//  CustomAnnotation.swift
//  blndIn
//
//  Created by Zyad Galal on 5/7/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject , MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title : String?
    var subtitle: String?
    
    init(pinTitle:String ,pinSubTitle:String,location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
    

   

}
