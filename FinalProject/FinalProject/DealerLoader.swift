//
//  DealerLoader.swift
//  FinalProject
//
//  Created by John Redlich on 11/9/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import Foundation
import SwiftyJSON

class DealerLoader {

    var Dealers = [Dealer] ()
    var data : JSON?
    
    
    init(url : String) {
        
        self.getDealerData(url)
        
        if data != nil {
            self.parseDealers()
        }
        else {
            println("No Data Values")
        }
        
    }
    
    private func getDealerData(url : String) {
        //load data from url param
        var endpoint = NSURL(string: url)
        var data = NSData(contentsOfURL : endpoint!)
        //Make it JSON data and pass it to SwiftyJSON to work with
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            let data = JSON(json)
            //set class data to our parsed JSON
            self.data = data
        }
    }
    

    private func parseDealers() {
        for(key: String, distances: JSON) in self.data! {
            for(key1: String, distance: JSON) in distances {
                if checkDupDealers(distance["name"].stringValue) {
                    Dealers.append(Dealer(
                        Name: distance["name"].stringValue,
                        address1: distance["addr1"].stringValue,
                        address2: distance["addr2"].stringValue,
                        address3: distance["addr3"].stringValue,
                        city: distance["city"].stringValue,
                        state: distance["state"].stringValue,
                        zip: distance["zip"].stringValue,
                        lat: distance["lat"].doubleValue,
                        long: distance["long"].doubleValue,
                        distance: distance["distance"].doubleValue
                        ))
                }
            }
        }
    }
    
    func checkDupDealers(dealerName : String)->Bool {
        if Dealers.count > 0 {
            for dealer in Dealers {
                //println(dealer)
                if dealer.Name == dealerName {
                    return false
                }
            }
            return true
        }
        else {
            return true
        }
    }
}