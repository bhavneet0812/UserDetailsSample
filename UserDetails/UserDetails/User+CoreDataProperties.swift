//
//  User+CoreDataProperties.swift
//  UserDetails
//
//  Created by Appinventiv on 25/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var userName: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var age: Int32
    @NSManaged public var dob: String?
    @NSManaged public var phone: Int64
    @NSManaged public var address: String?

}
