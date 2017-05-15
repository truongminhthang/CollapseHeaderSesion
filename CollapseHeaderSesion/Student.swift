//
//  Student.swift
//  CollapseHeaderSesion
//
//  Created by Trương Thắng on 5/15/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation

class Student {
    var firstName: String = ""
    var lastName: String = ""
    var nameOfClass: String = ""
    var id: String = ""
    var dob: String?
    
    init(dictionary: Dictionary<AnyHashable,Any>) {
         firstName = dictionary["firstName"] as? String ?? ""
        lastName = dictionary["lastName"] as? String ?? ""
        nameOfClass = dictionary["class"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        dob = dictionary["dob"] as? String ?? "" 
    }
}
