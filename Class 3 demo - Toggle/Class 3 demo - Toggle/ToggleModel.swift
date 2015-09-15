//
//  ToggleModel.swift
//  Class 3 demo - Toggle
//
//  Created by John Redlich on 9/8/15.
//  Copyright (c) 2015 John Redlich. All rights reserved.
//

import Foundation

class ToggleModel {
    
    var messages = ["Hi", "Bye"]
    var currentMessage = 0
    
    func getMessage()->String {
        return messages[currentMessage]
    }
    
    func nextMessage() {
        currentMessage = (currentMessage+1) % messages.count
    }
    
    func addMessage(m: String) {
        if !messages.isEmpty {
            messages.append(m)
        }
    }
    
    func isMessagesPresent(m: String)->Bool {
        return find(messages, m) != nil
    }
    
    func deleteMessage(m: String) {
        if let index = find(messages, m) {
            if messages.count > 1 {
                messages.removeAtIndex(index)
            }
        }
    }
}