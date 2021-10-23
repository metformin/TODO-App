//
//  Validation.swift
//  TODO App
//
//  Created by Darek on 16/10/2021.
//

import Foundation
 

class Validation {
    static let shared = Validation()
    
    public func validateTaskTitle(title: String) -> Bool {
       // Length be 40 characters max and 1 characters minimum.
       let titleRegex = "^[\\p{L} a-zA-Z0-9 ]{2,40}$"
       let validateTitle = NSPredicate(format: "SELF MATCHES %@", titleRegex)
       let isValidateTitle = validateTitle.evaluate(with: title)
       return isValidateTitle
    }
}
