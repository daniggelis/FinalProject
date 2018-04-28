//
//  Bikes.swift
//  FinalProject
//
//  Created by Tiffany on 4/24/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import Foundation
import Firebase

class Bikes{
    var bikesArray: [Bike] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("bikes").addSnapshotListener { (querySnapshot, error) in
            self.bikesArray = []
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            // there are querySnapshot!.documents.count documents
            for document in querySnapshot!.documents {
                let bike = Bike(dictionary: document.data())
                bike.documentID = document.documentID
                self.bikesArray.append(bike)
            }
            completed()
        }
    }
}

