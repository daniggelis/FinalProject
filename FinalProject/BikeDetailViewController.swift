//
//  BikeDetailViewController.swift
//  FinalProject
//
//  Created by Tiffany on 4/24/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import MapKit

class BikeDetailViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UILabel!
    @IBOutlet weak var lenderField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var bike: Bike!
    let regionDistance: CLLocationDistance = 750
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
      
        if bike == nil {
            bike = Bike(name: "", address: "", coordinate: CLLocationCoordinate2D() , lender: "")
        }
        
        let region = MKCoordinateRegionMakeWithDistance(bike.coordinate, regionDistance, regionDistance)
        mapView.setRegion(region, animated: true)
        updateUserInterface()
    }
    
    func updateUserInterface(){
        nameField.text = bike.name
        locationField.text = bike.address
        lenderField.text = bike.lender
        updateMap()
    }
    
    func updateMap(){
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(bike)
        mapView.setCenter(bike.coordinate, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromSave"{
            bike.name = nameField.text!
            bike.address = locationField.text!
            bike.lender = lenderField.text!
        }
    }
    
    
    @IBAction func lookUpPressed(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
        
    }
}

extension BikeDetailViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        bike.address = place.formattedAddress ?? ""
        bike.coordinate = place.coordinate
        
        dismiss(animated: true, completion: nil)
        updateUserInterface()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
