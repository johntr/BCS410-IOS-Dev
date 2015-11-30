//
//  DealerMapViewController.swift
//  
//
//  Created by John Redlich on 11/11/15.
//
//

import UIKit
import MapKit
import AddressBook

class DealerMapViewController: UIViewController, MKMapViewDelegate {

    var selectedDealer : Dealer?
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        if let selectedLat = selectedDealer?.lat! {
            if let selectedLong = selectedDealer?.long! {
                let initalLocation = CLLocation(latitude: selectedLat, longitude: selectedLong)
                centerMapOnLocation(initalLocation)
                
                if let selectedCoor = selectedDealer?.coordinate {
                    
                
                var pinLocation : CLLocationCoordinate2D = selectedCoor
                
                var objectAnnotation = MKPointAnnotation()
                objectAnnotation.coordinate = pinLocation
                objectAnnotation.title = selectedDealer?.title
                objectAnnotation.subtitle = selectedDealer?.subtitle

                var annotationView = MKPinAnnotationView(annotation: objectAnnotation, reuseIdentifier: "pin")
                annotationView.enabled = true
                annotationView.canShowCallout = true
                annotationView.calloutOffset = CGPoint(x: -5, y: 5)
                annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                
                self.mapView.addAnnotation(annotationView.annotation)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "pin"

            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                //let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                return annotationView
            }

    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        let addressDictionary =
        [kABPersonAddressStreetKey as NSString : selectedDealer!.address1!,
            kABPersonAddressCityKey : selectedDealer!.city!,
            kABPersonAddressStateKey : selectedDealer!.state!,
            kABPersonAddressZIPKey : selectedDealer!.zip!] as [NSObject : AnyObject]
        
        let placemark = MKPlacemark(coordinate: selectedDealer!.coordinate, addressDictionary: addressDictionary )
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
