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
    
    let UserDetailCell = Xib(name: "TableViewCell", id: "TableViewCellID")
    var users = [User]()
    var userData = Database()
    var dbHelper = DBHelper()
    


    
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

        
        dbHelper.saveData()
        
        let _ = navigationController?.popViewController(animated: true)
        
    }

}

// MARK: userDetailsTable - Delegate and Datasource Methods

extension UserDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.id, for: indexPath) as? TableViewCell else { fatalError("Error while dequeue table cell.") }
        
        cell.detailTField.enablesReturnKeyAutomatically = true
        cell.detailTField.delegate = self
        switch indexPath.row {
        case 0:
            
            cell.detailLabel.text = userData.firstName
            cell.detailTField.placeholder = "Bhavneet"
            cell.detailTField.autocapitalizationType = .words
            
        case 1:
            
            cell.detailLabel.text = userData.lastName
            cell.detailTField.placeholder = "Singh"
            cell.detailTField.autocapitalizationType = .words

        case 2:
            
            cell.detailLabel.text = userData.userName
            cell.detailTField.placeholder = "bhavneet.singh"

        case 3:
            
            cell.detailLabel.text = userData.email
            cell.detailTField.placeholder = "bhavneet.singh@appinventiv.com"

        case 4:
            
            cell.detailLabel.text = userData.password
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
            
            cell.detailLabel.text = userData.dob
            cell.detailTField.placeholder = "08 Dec 1993"

        case 8:
            
            cell.detailLabel.text = "Phone No."
            cell.detailTField.placeholder = "9654088085"
            cell.detailTField.keyboardType = .phonePad


        default:
            
            cell.detailLabel.text = userData.address
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
            
            dbHelper.firstName = textField.text!
            print(#function)
            
        case 1:
            
            dbHelper.lastName = textField.text!
            print(#function)

        case 2:
            
            dbHelper.userName = textField.text!
            print(#function)
            
        case 3:
            
            dbHelper.email = textField.text!
            print(#function)

        case 4:
            
            dbHelper.password = textField.text!
            print(#function)

        case 5:
            
            if textField.text != dbHelper.password {
//                let alert = UIAlertController(title: "Password Mismatch", message: "Re-Enter Password", preferredStyle: .alert)
//                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alert.addAction(action)
//                alert.present(alert, animated: true, completion: { textField.text = "" })
                userData.password = ""
            }
            print(#function)

        case 6:

            dbHelper.age = Int(textField.text!)!
            print(#function)

        case 7:
            
            dbHelper.dob = textField.text!
            print(#function)

        case 8:
            
            dbHelper.phone = Int64(textField.text!)!
            print(#function)

        default:
            
            dbHelper.address = textField.text!
            print(#function)

        }
    }
    
}
