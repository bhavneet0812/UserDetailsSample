//
//  DBhelper.swift
//  HitList
//
//  Created by MAC on 24/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBHelper {
    
// MARK: Variables
    
    var users = [User]()
    
    var firstName: String
    
    var lastName: String
    
    var userName: String
    
    var email: String
    
    var password: String
    
    var age: Int
    
    var dob: String
    
    var phone: Int64
    
    var address: String?
    
    // Initializers
    
    init() {
        
       self.firstName = ""
        
        self.lastName = ""
        
        self.userName = ""
        
        self.email = ""
        
        self.password = ""
        
        self.age = 0
        
        self.dob = ""
        
        self.phone = 0
        
        self.address = ""
        
    }
    
    init(firstName : String, lastName : String, userName : String, email : String, password : String, age : Int, dob : String, phone : Int64, address : String) {
        
        self.firstName = firstName
        
        self.lastName = lastName
        
        self.userName = userName
        
        self.email = email
        
        self.password = password
        
        self.age = age
        
        self.dob = dob
        
        self.phone = phone
        
        self.address = address
        
    }
    
}

extension DBHelper {
    
// MARK: SaveData Method
    
    func saveData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User" , in: managedContext)!
        
        let user = User(entity: entity , insertInto: managedContext)
        
        user.firstName = firstName
        
        user.lastName = lastName
        
        user.userName = userName
        
        user.email = email
        
        user.password = password
        
        user.age = age
        
        user.dob = dob
        
        user.phone = phone
        
        user.address = address
        
        do {
            
            try managedContext.save()
            
            users.append(user)
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
    }
    
// MARK: getData Method

    func getData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            users = try managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
    }
    
//MARK: deleteData Method

    func deleteData(_ deleteSpecificData : User) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(deleteSpecificData)
        
        do {
            
            try managedContext.save()
            
        }
        catch _ {
            
        }
        
    }
    
//MARK: editAtPerson Method
    
    func editAtUser(_ atUser : User , _ userIndex : Int)		{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            users = try managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        users[userIndex].firstName = atUser.firstName
        users[userIndex].lastName = atUser.lastName
        users[userIndex].userName = atUser.userName
        users[userIndex].email = atUser.firstName
        users[userIndex].password = atUser.firstName
        users[userIndex].age = atUser.age
        users[userIndex].dob = atUser.dob
        users[userIndex].phone = atUser.phone
        users[userIndex].address = atUser.address
        
        do{
            
            try managedContext.save()
            
            print("saved")
            
        }catch let error as NSError {
            
            print("Could not save \(error)")
            
        }
        
    }
    
}
