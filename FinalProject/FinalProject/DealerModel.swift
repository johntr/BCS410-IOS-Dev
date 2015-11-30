//
//  DealerModel.swift
//  FinalProject
//
//  Created by John Redlich on 11/9/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class Dealer: NSObject, MKAnnotation {
    
    let title : String!
    let subtitle: String!
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let state : String?
    let zip : String?
    let lat : Double?
    let long : Double?
    var distance : Double?
    var coordinate : CLLocationCoordinate2D

    
    init(Name : String, address1 : String, address2 : String?, address3 : String?, city : String, state : String, zip : String, lat : Double, long : Double, distance : Double) {
        
        self.title = Name

        self.address1 = address1
        if let address2unwrapped = address2 {
            self.address2 = address2unwrapped
        }
        else {
            self.address2 = nil
        }
        if let address3unwrapped = address3 {
            self.address3 = address3unwrapped
        }
        else {
            self.address3 = nil
        }
        self.city = city
        self.state = state
        self.zip = zip
        self.lat = lat
        self.long = long
        self.distance = distance
        self.coordinate = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.long!)
        self.subtitle = "About \(distance) Miles away."
        super.init()
    }
    /*
    func mapItem() -> MKMapItem {
        let addressDictionary =
        [kABPersonAddressStreetKey as NSString : address1!,
            kABPersonAddressCityKey : city!,
            kABPersonAddressStateKey : state!,
            kABPersonAddressZIPKey : zip!] as [NSObject : AnyObject]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary )
        //let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
*/
}