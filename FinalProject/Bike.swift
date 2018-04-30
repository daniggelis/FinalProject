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
import Firebase
import MapKit

class Bike: NSObject, MKAnnotation{
    
    var availability: String
    var address: String
    var placeName: String
    var coordinate: CLLocationCoordinate2D
    var lender: String
    var documentID: String
    
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
        return ["availability": availability, "address": address, "placeName": placeName, "longitude": coordinate.longitude, "latitude": coordinate.latitude, "lender": lender]
    }
    
    init(availability: String, address: String, placeName: String, coordinate: CLLocationCoordinate2D, lender: String, documentID: String){
        self.availability = availability
        self.address = address
        self.placeName = placeName
        self.coordinate = coordinate
        self.lender = lender
        self.documentID = documentID
    }
    
    convenience override init() {
        self.init(availability: "Available", address: "", placeName: "", coordinate: CLLocationCoordinate2D(), lender: (Auth.auth().currentUser?.email)!, documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let availability = dictionary["availability"] as! String? ?? ""
        let address = dictionary["address"] as! String? ?? ""
        let placeName = dictionary["placeName"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let lender = dictionary["lender"] as! String? ?? ""
        
        self.init(availability: availability, address: address, placeName: placeName, coordinate: coordinate, lender: lender, documentID: "")
    }
    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the userID
//        guard let lender = (Auth.auth().currentUser?.email) else {
//            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
//            return completed(false)
//        }
        print("*************")
        //self.lender = lender
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("bikes").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    self.documentID = ref.documentID
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // Let firestore create the new documentID
            ref = db.collection("bikes").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
}




