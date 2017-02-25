//
//  UserDetailVC.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class UserDetailVC: UIViewController {
    
// MARK: Variables
    
    let UserDetailCell = Xib(name: "UserDetailCell", id: "UserDetailCellID")
    var users = [User]()
    var data = Database()
    
// MARK: IBOutlets

    @IBOutlet weak var userDetailNavigation: UINavigationItem!
    
    @IBOutlet weak var userDetailsTable: UITableView!
    
// MARK: UserDetails Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        userDetailsTable.delegate = self
        userDetailsTable.dataSource = self
        
        let userDetailCellNib = UINib(nibName: UserDetailCell.name, bundle: nil)
        userDetailsTable.register(userDetailCellNib, forCellReuseIdentifier: UserDetailCell.id)

    }
    
// MARK: IBActions

    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "User",
                                                in: managedContext)!
        
        let user = User(entity: entity,
                            insertInto: managedContext)
        
        user.firstName = data.firstName //setValue(name, forKeyPath: "name")
        user.lastName = data.lastName
        user.userName = data.userName
        user.email = data.email
        user.password = data.password
        user.age = Int32(data.age)
        user.dob = data.dob
        user.phone = data.phone
        user.address = data.address
        
        do {
            try managedContext.save()
            
            users.append(user)
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "UsersID") else {
            print("View controller Six not found")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

// MARK: userDetailsTable - Delegate and Datasource Methods

extension UserDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.id, for: indexPath) as? UserDetailCell else { fatalError("Error while dequeue table cell.") }
        
        cell.detailTField.enablesReturnKeyAutomatically = true
        cell.detailTField.delegate = self
        switch indexPath.row {
        case 0:
            
            cell.detailLabel.text = data.firstName
            cell.detailTField.placeholder = "Bhavneet"
            cell.detailTField.autocapitalizationType = .words
            
        case 1:
            
            cell.detailLabel.text = data.lastName
            cell.detailTField.placeholder = "Singh"
            cell.detailTField.autocapitalizationType = .words

        case 2:
            
            cell.detailLabel.text = data.userName
            cell.detailTField.placeholder = "bhavneet.singh"

        case 3:
            
            cell.detailLabel.text = data.email
            cell.detailTField.placeholder = "bhavneet.singh@appinventiv.com"

        case 4:
            
            cell.detailLabel.text = data.password
            cell.detailTField.placeholder = "#123abc#"
            cell.detailTField.isSecureTextEntry = true

        case 5:
            
            cell.detailLabel.text = "Re-Enter Password"
            cell.detailTField.placeholder = "Re-Enter Password"
            cell.detailTField.isSecureTextEntry = true

        case 6:
            
            cell.detailLabel.text = "Age"
            cell.detailTField.placeholder = "23"
            cell.detailTField.keyboardType = .numberPad


        case 7:
            
            cell.detailLabel.text = data.dob
            cell.detailTField.placeholder = "08 Dec 1993"

        case 8:
            
            cell.detailLabel.text = "Phone No."
            cell.detailTField.placeholder = "9654088085"
            cell.detailTField.keyboardType = .phonePad


        default:
            
            cell.detailLabel.text = data.address
            cell.detailTField.placeholder = "Sector 62, Noida"
            cell.detailTField.autocapitalizationType = .words
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}

// MARK: Text Field - Delegate and Datasource Methods

extension UserDetailVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cell = textField.getTableViewCell else { return }
        let index = userDetailsTable.indexPath(for: cell)
        
        switch index!.row {
        case 0:
            
            data.firstName = textField.text!
            print(#function)
            
        case 1:
            
            data.lastName = textField.text!
            print(#function)

        case 2:
            
            data.userName = textField.text!
            print(#function)
            
        case 3:
            
            data.email = textField.text!
            print(#function)

        case 4:
            
            data.password = textField.text!
            print(#function)

        case 5:
            
            if textField.text != data.password {
//                let alert = UIAlertController(title: "Password Mismatch", message: "Re-Enter Password", preferredStyle: .alert)
//                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alert.addAction(action)
//                alert.present(alert, animated: true, completion: { textField.text = "" })
                data.password = ""
            }
            print(#function)

        case 6:
            
            data.age = Int(textField.text!)!
            print(#function)

        case 7:
            
            data.dob = textField.text!
            print(#function)

        case 8:
            
            data.phone = Int64(textField.text!)!
            print(#function)

        default:
            
            data.address = textField.text!
            print(#function)

        }
    }
    
}

// Extension - UserDetailVC

extension UserDetailVC {

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

}
