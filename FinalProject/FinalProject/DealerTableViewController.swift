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

class DealerTableViewController: UITableViewController, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    var domain = "app-adc.gotpantheon.com"
    
    var Dealers : DealerLoader?
    var selectedDealer : Dealer?
    
    let location = CLLocationManager()
    var zip :String = ""
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadDealers:",name:"load", object: nil)
        
        activitySpinner.startAnimating()
        
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
        if let count = Dealers {
            return count.Dealers.count
        } else {
            return 0
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DealerTableViewCellReuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        if let myCell = cell as? DealerTableViewCell {
            //println(Dealers?.Dealers[indexPath.row].title)
            myCell.nameLabel.text = Dealers?.Dealers[indexPath.row].title
            myCell.addressLabel.text = Dealers?.Dealers[indexPath.row].address1
            if let city = Dealers?.Dealers[indexPath.row].city {
                if let state = Dealers?.Dealers[indexPath.row].state {
                    if let zip = Dealers?.Dealers[indexPath.row].zip {
                        myCell.cityLabel.text = "\(city), \(state) \(zip)"
                    }
                }
            }

            if let distance = Dealers?.Dealers[indexPath.row].distance {
                myCell.distanceLabel.text = "\(distance) Miles"
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
                let defaultZip = ["Zip" : (placemark.postalCode != nil) ? placemark.postalCode : ""]
                
                NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil, userInfo: defaultZip)
            }else{
                self.showAlertToUser("No Dealers found")
                println("No placemarks found.")
            }
        })
    }
    //Notification "load" will call this function
    func loadDealers(param: NSNotification){

        if let paramZip = param.userInfo as? Dictionary<String, String!> {
            self.zip = paramZip["Zip"]!
            
            if count(self.zip) == 5 {
            Dealers = DealerLoader(url:"http://\(self.domain)/api/v1/dealers/\(self.zip)")
            }
            else {
                self.showAlertToUser("Invalid zip entered")
                println("Invalid zip")
            }
            
        } else {
            println("No zip found in Notification")
        }
        
        self.reloadTable()
        
    }
    
    func reloadTable() {
        if Dealers != nil && Dealers!.Dealers.count > 0{
            self.tableView.reloadData()
            activitySpinner.stopAnimating()

        } else {
            showAlertToUser("No Dealers found")
            println("No Dealers Loaded" )
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: \(error.localizedDescription)")
    }
    
    // MARK: - Popover
    
    @IBAction func menuUpdateZip(sender: AnyObject) {

        var popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as? PopoverViewController
        
        popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        popoverViewController?.popoverPresentationController?.delegate = self

        self.presentViewController(popoverViewController!, animated: true, completion: nil)
        
        popoverViewController?.popoverPresentationController?.barButtonItem = menuButton
        popoverViewController?.popoverPresentationController?.permittedArrowDirections = .Any
        popoverViewController?.preferredContentSize = CGSizeMake(200.0, 80.0)
        

    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    // MARK: - App Navigation

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
    
    // MARK: --Alerts
    func showAlertToUser(alert:String) {
        
        let alertController = UIAlertController(title: "ADC Dealer Locator", message:
            alert, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}
