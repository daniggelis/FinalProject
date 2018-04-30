//
//  ViewController.swift
//  FinalProject
//
//  Created by Tiffany on 4/24/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapViewVC: MKMapView!
    
    var bikeArray = [Bike]()
    var bikes = Bikes()
    var bike: Bike!
    let regionDist: CLLocationDistance = 1000
    var originalCoordinate = CLLocationCoordinate2D()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //mapViewVC.delegate = self
        originalCoordinate.latitude = 42.334773
        originalCoordinate.longitude = -71.170126
        // set to Fulton Hall
        bikes.loadData {
            self.bikeArray = self.bikes.bikesArray
            self.addAnnotations()
            
        }
        
        
        let region = MKCoordinateRegionMakeWithDistance(originalCoordinate, regionDist, regionDist)
        mapViewVC.setRegion(region, animated: true)
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addAnnotations()
        if bikes != nil{
            bikes.loadData {
            self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBike"{
            let destination = segue.destination as! BikeDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            destination.bike = bikeArray[index!]

        }
    }
    
    func addAnnotations(){
         mapViewVC.removeAnnotations(mapViewVC.annotations)
        
        if bikeArray.count > 0{
            for index in 0...bikeArray.count-1{
            //mapView.addAnnotation(bike)
                mapViewVC.addAnnotation(bikeArray[index] as MKAnnotation)
                mapViewVC.selectAnnotation(mapViewVC.annotations[index], animated: true)
            }
        }
    }
    
    func leaveViewController(){
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue){
        let sourceViewContoller = segue.source as! BikeDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            addAnnotations()
            bikeArray[indexPath.row] = sourceViewContoller.bike
            tableView.reloadRows(at: [indexPath], with: .automatic)
            sourceViewContoller.saveIt()
        }else{
            addAnnotations()
            let newIndexPath = IndexPath(row: bikeArray.count, section: 0)
            bikeArray.append(sourceViewContoller.bike)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            sourceViewContoller.saveIt()
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

