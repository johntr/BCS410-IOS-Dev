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
        
        var newZip = ["Zip":zipField.text]
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil, userInfo: newZip)
       
        var tmpController :UIViewController! = self.presentingViewController;
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            println("done");
            tmpController.dismissViewControllerAnimated(false, completion: nil);
        });

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
