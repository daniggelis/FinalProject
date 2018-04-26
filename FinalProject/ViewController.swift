//
//  ViewController.swift
//  FinalProject
//
//  Created by Tiffany on 4/24/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapViewVC: MKMapView!
    
    var bikeArray = [Bike]()
    var bikes: Bike!
    let regionDist: CLLocationDistance = 750
    var originalCoordinate = CLLocationCoordinate2D()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        tableView.delegate = self
        tableView.dataSource = self
        //mapViewVC.delegate = self
        originalCoordinate.latitude = 42.334773
        originalCoordinate.longitude = -71.170126
        // set to Fulton Hall
        
        
        let region = MKCoordinateRegionMakeWithDistance(originalCoordinate, regionDist, regionDist)
        mapViewVC.setRegion(region, animated: true)
      
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBike"{
            let destination = segue.destination as! BikeDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            destination.bike = bikeArray[index!]

        }
    }
    
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewContoller = segue.source as! BikeDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            bikeArray[indexPath.row] = sourceViewContoller.bike
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else{
            let newIndexPath = IndexPath(row: bikeArray.count, section: 0)
            bikeArray.append(sourceViewContoller.bike)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bikeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = bikeArray[indexPath.row].address
        cell.detailTextLabel?.text = bikeArray[indexPath.row].availability
        return cell
    }
}

