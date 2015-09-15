//
//  ToggleViewController.swift
//  Class 3 demo - Toggle
//
//  Created by John Redlich on 9/8/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import UIKit

class ToggleViewController: UIViewController {

    @IBOutlet weak var mainOutlet: UILabel!
    @IBOutlet weak var newTextInput: UITextField!
    @IBOutlet weak var messageButton: UIButton!
    
    var toggleModel = ToggleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainOutlet.text = toggleModel.getMessage()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - My Code
    @IBAction func toggle() {
        toggleModel.nextMessage()
        mainOutlet.text = toggleModel.getMessage()
    }

    @IBAction func adddeleteMessageAction(sender: UIButton) {
        if messageButton.titleLabel?.text == "Delete" {
            toggleModel.deleteMessage(newTextInput.text)
        }
        else {
            toggleModel.addMessage(newTextInput.text)
        }
        newTextInput.text = ""
        textDidChange(newTextInput)
    }
    @IBAction func textDidChange(sender: UITextField) {
        if toggleModel.isMessagesPresent(sender.text) {
            messageButton.setTitle("Delete", forState: .Normal)
        }
        else {
            messageButton.setTitle("Add", forState: .Normal)
        }
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
