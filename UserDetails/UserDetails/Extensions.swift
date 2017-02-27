//
//  Extensions.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

extension UIView {
    
    var getTableViewCell : UITableViewCell?{
        
        var cell = self
        while !(cell is UITableViewCell) {
            
            guard let s = cell.superview else {return nil}
            cell = s
            
        }
        return cell  as? UITableViewCell   }
    
    var getCollectionViewCell : UICollectionViewCell?{
        
        var cell = self
        while !(cell is UICollectionViewCell) {
            
            guard let s = cell.superview else {return nil}
            cell = s
            
        }
        return cell as? UICollectionViewCell
    }
        
}

struct Xib {
    var name : String
    var id : String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}


struct Database {
    
    var firstName : String
    var lastName : String
    var userName : String
    var email : String
    var password : String
    var age : Int
    var dob : String
    var phone : Int64
    var address : String
    
    init() {
        
        firstName = "First Name"
        lastName = "Last Name"
        userName = "Username"
        email = "Email ID"
        password = "Password"
        age = 0
        dob = "Date Of Birth"
        phone = 9999999999
        address = "Address"
        
    }
    
}

enum TFieldEditable {
    case yes
    case no
}

var editIndex : IndexPath? = nil

//(UITableViewRowAction, indexPath) -> Void in
//
//let moc = self.getContext()
//
//let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//
//let result = try? moc.fetch(fetchRequest)
//
//let resultData = result as! [User]
//
//for object in resultData {
//    
//    object.firstName! = "\(object.firstName!) Joshi"
//    
//    print(object.firstName!)
//    
//}
//
//do{
//    
//    try moc.save()
//    
//    print("saved")
//    
//}catch let error as NSError {
//    
//    print("Could not save \(error), \(error.userInfo)")
//    
//}


