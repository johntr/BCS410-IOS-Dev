//
//  DealerMapViewController.swift
//  
//
//  Created by John Redlich on 11/11/15.
//
//

import UIKit
import MapKit

class DealerMapViewController: UIViewController {

    var selectedDealer : Dealer?
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedLat = selectedDealer?.lat! {
            if let selectedLong = selectedDealer?.long! {
                let initalLocation = CLLocation(latitude: selectedLat, longitude: selectedLong)
                centerMapOnLocation(initalLocation)
                

                //var pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(selectedLat, selectedLong)
                
                var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(selectedLat, selectedLong)
                var objectAnnotation = MKPointAnnotation()
                objectAnnotation.coordinate = pinLocation
                objectAnnotation.title = selectedDealer?.title
                objectAnnotation.subtitle = selectedDealer?.subtitle
                self.mapView.addAnnotation(objectAnnotation)
                //centerMapOnLocation(pinLocation)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
