//
//  PopoverViewController.swift
//  
//
//  Created by John Redlich on 11/17/15.
//
//

import UIKit

class PopoverViewController: UIViewController {

    
    @IBOutlet weak var zipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateZip(sender: AnyObject) {
        //pass our new zip and post it to the notification center.
        var newZip = ["Zip":zipField.text]
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil, userInfo: newZip)
       
        var tmpController :UIViewController! = self.presentingViewController;
        //close the popover
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            tmpController.dismissViewControllerAnimated(false, completion: nil);
        });

    }

}
