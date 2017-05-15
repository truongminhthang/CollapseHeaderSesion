//
//  DataServices.swift
//  CollapseHeaderSesion
//
//  Created by Trương Thắng on 5/15/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation

class DataServices {
    static let shared : DataServices = DataServices()
    private var _students: [String: Array<Student>]?
    
    var students: [String: Array<Student>] {
        set {
            _students = newValue
        }
        get {
            if _students == nil {
                updatePeople()
            }
            return _students ?? [:]
        }
    }
    
    func updatePeople() {
        _students = [:]
        let dict = PlistServices().getDictionaryFrom(plist: "Students.plist")
        guard let studentDicts = dict?["Students"] as? [Dictionary<AnyHashable, Any>] else {
            return
        }
        
        for item in studentDicts {
            let student = Student(dictionary: item)
            if _students?[student.nameOfClass] == nil {
                _students?[student.nameOfClass] = []
            }
            _students?[student.nameOfClass]?.append(student)
        }
        
        NotificationCenter.default.post(name: NotificationName.didUpdatePeople, object: nil)
    }
}


struct NotificationName {
    static let didUpdatePeople = NSNotification.Name.init("didUpdatePeople")
}

class PlistServices {
    func getDictionaryFrom(plist: String) -> Dictionary<AnyHashable, Any>? {
        var result : Dictionary<AnyHashable, Any>?
        let fileNameComponents = plist.components(separatedBy: ".")
        guard let filePath = Bundle.main.path(forResource: fileNameComponents.first ?? "", ofType: fileNameComponents.last ?? "") else {
            return nil
        }
        
        guard FileManager.default.fileExists(atPath: filePath) == true else {
            return nil
        }
        
        guard let data = FileManager.default.contents(atPath: filePath) else {
            return nil
        }
        do {
            guard let root = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? Dictionary<AnyHashable, Any> else {
                return nil
            }
            result = root
            
        } catch {
            print("Error: PropertyListSerialization error")
        }
        
        return result
        
    }
}
