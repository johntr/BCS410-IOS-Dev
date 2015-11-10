//
//  DealerModel.swift
//  FinalProject
//
//  Created by John Redlich on 11/9/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import Foundation

class Dealer {
    
    let Name : String?
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let state : String?
    let zip : String?
    let lat : Double?
    let long : Double?
    var distance : Double?
    
    
    init(Name : String, address1 : String, address2 : String?, address3 : String?, city : String, state : String, zip : String, lat : Double, long : Double, distance : Double) {
        
        self.Name = Name
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
        
    }
}