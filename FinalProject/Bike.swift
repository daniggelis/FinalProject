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
    
    var availability: String
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
        return availability
    }
    var subtitle: String?{
        return address
    }
    
    var dictionary: [String: Any]{
        return ["availability": availability, "address": address, "coordinate": coordinate, "lender": lender]
    }
    
    init(availability: String, address: String, coordinate: CLLocationCoordinate2D, lender: String){
        self.availability = availability
        self.address = address
        self.coordinate = coordinate
        self.lender = lender
    }

}



