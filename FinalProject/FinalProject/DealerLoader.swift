//
//  DealerLoader.swift
//  FinalProject
//
//  Loads dealers from a URL into the Dealer objects
//
//  Created by John Redlich on 11/9/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import Foundation
import SwiftyJSON

class DealerLoader {

    var Dealers = [Dealer] ()
    var data : JSON?
    
    
    init(url : NSURL) {
        
        self.getDealerData(url)
        
        //check if we get data from our url
        if self.data != nil {
            self.parseDealers()
        }
        else {
            println("No Data Values")
        }
        
    }
    //get dealer data from endpoint
    private func getDealerData(url : NSURL) {
        //load data from url param
        //var endpoint = NSURL(string: url)

        var data = NSData(contentsOfURL : url)
        //Make it JSON data and pass it to SwiftyJSON to work with
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            let data = JSON(json)
            //set class data to our parsed JSON
            self.data = data
        }
    }
    
    //Here we parse our dealers into objects and add to the Dealers array.
    private func parseDealers() {
        for(key: String, distances: JSON) in self.data! {
            for(key1: String, distance: JSON) in distances {
                if checkDupDealers(distance["name"].stringValue) {
                    //append to Dealer array
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
    //Here we are going to check if we already have that dealer so we dont have any duplicate to adjust
    //for incomming data structure. The incomming data is layed out for mile increments, we want to flatten and combine.
    func checkDupDealers(dealerName : String)->Bool {
        //if its the first one we dont need to check.
        if Dealers.count > 0 {
            //go through dealers and make sure there are no dup names. 
            for dealer in Dealers {
                //println(dealer)
                if dealer.title == dealerName {
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