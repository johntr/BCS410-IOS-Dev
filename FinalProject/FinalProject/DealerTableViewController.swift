//
//  DealerTableViewController.swift
//  
//
//  Created by John Redlich on 11/7/15.
//
//

import UIKit
import MapKit
import CoreLocation

class DealerTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var Dealers : DealerLoader?
    var selectedDealer : Dealer?
    
    let location = CLLocationManager()
    var zip :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyHundredMeters
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 8//return Dealers!.Dealers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DealerTableViewCellReuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        if let myCell = cell as? DealerTableViewCell {
            myCell.cellTitle.text = Dealers?.Dealers[indexPath.row].title
            if let distance = Dealers?.Dealers[indexPath.row].distance {
                myCell.detailTextLabel!.text = "\(distance) Miles"
            }

            return myCell
        }
        return cell
    }
    
    // MARK: - Location Management
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)-> Void in
            if error != nil {
                println("Reverse geocoder failed with error: \(error.localizedDescription)")
                return
            }
            
            if placemarks.count > 0 {
                let placemark = placemarks[0] as! CLPlacemark
                self.location.stopUpdatingLocation()
                self.loadDealers(placemark)
                
            }else{
                println("No placemarks found.")
            }
        })
    }
    
    func loadDealers(placemark: CLPlacemark){
        zip = (placemark.postalCode != nil) ? placemark.postalCode : ""
        //println("Postal code updated to: \(self.zip)")
        Dealers = DealerLoader(url:"http://app-adc.gotpantheon.com/api/v1/dealers/\(self.zip)")
        
        if Dealers != nil {
            tableView.reloadData()
        } else {
            println("No Dealers Loaded" )
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: \(error.localizedDescription)")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "selectedDealerSegue" {
            let selectedCell = self.tableView.indexPathForCell(sender as! UITableViewCell)
            let selectedDealer = Dealers?.Dealers[selectedCell!.row]
            var viewController = segue.destinationViewController as! DealerMapViewController
            viewController.selectedDealer = selectedDealer
        }
    }
    

}
