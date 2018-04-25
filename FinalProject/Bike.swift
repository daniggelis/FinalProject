//
//  Bike.swift
//  FinalProject
//
//  Created by Tiffany on 4/24/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import Foundation
import GooglePlaces
import CoreLocation
import MapKit

class Bike: NSObject, MKAnnotation {
    
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var lender: String
    
    var longitude: CLLocationDegrees{
        return coordinate.longitude
    }
    var latitude: CLLocationDegrees{
        return coordinate.latitude
    }
    
    var title: String? {
        return name
    }
    var subtitle: String?{
        return address
    }
    
    var dictionary: [String: Any]{
        return ["name": name, "address": address, "coordinate": coordinate, "lender": lender]
    }
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D, lender: String){
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.lender = lender
    }

}



