//
//  EditUserVC.swift
//  UserDetails
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class EditUserVC: UIViewController {
    

// MARK: Variables
    
    let editUserCell = Xib(name: "TableViewCell", id: "TableViewCellID")
    var editData = Database()
    var editIndex : IndexPath? = nil
    var text : TFieldEditable = .yes
    var person : User! = nil
    var personIndex = Int()
    var dbHelper = DBHelper()
    
    
// MARK: IBOutlets
    
    @IBOutlet weak var editTable: UITableView!
    
    @IBOutlet weak var editDoneBtn: UIBarButtonItem!
// MARK: UserDetailsCell Lif Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTable.delegate = self
        editTable.dataSource = self
        
        let editCell = UINib(nibName: editUserCell.name, bundle: nil)
        editTable.register(editCell, forCellReuseIdentifier: editUserCell.id)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: IBActions
    
    @IBAction func editDoneBtn(_ sender: UIBarButtonItem) {
        
            dbHelper.editAtUser(person, personIndex)
        
        
       
            let _ = navigationController?.popViewController(animated: true)
        
    }
    
    func updateData(index : IndexPath) -> Void {
        
        let moc = self.getContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let result = try? moc.fetch(fetchRequest)
        
        let resultData = result as! [User]
        
        let object = resultData[index.row]
        
        object.firstName = editData.firstName //setValue(name, forKeyPath: "name")
        object.lastName = editData.lastName
        object.userName = editData.userName
        object.email = editData.email
        object.password = editData.password
        object.age = editData.age
        object.dob = editData.dob
        object.phone = editData.phone
        object.address = editData.address
        
        do{
            
            try moc.save()
            
            print("saved")
            
        }catch let error as NSError {
            
            print("Could not save \(error), \(error.userInfo)")
            
        }

    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

// MARK: EditUserVC - Delegate and Datasource Methods

extension EditUserVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: editUserCell.id, for: indexPath) as? TableViewCell else { fatalError("Error while dequeue table cell.") }
        
        cell.detailTField.enablesReturnKeyAutomatically = true
        cell.detailTField.delegate = self
        
        if text == .no {
            cell.detailTField.isEnabled = false
        }
        
        switch indexPath.row {
        case 0:
            
            cell.detailLabel.text = "First Name"
            cell.detailTField.text = person.firstName
            cell.detailTField.autocapitalizationType = .words
            
        case 1:
            
            cell.detailLabel.text = "Last Name"
            cell.detailTField.text = person.lastName
            cell.detailTField.autocapitalizationType = .words
            
        case 2:
            
            cell.detailLabel.text = "Username"
            cell.detailTField.text = person.userName
            
        case 3:
            
            cell.detailLabel.text = "Email"
            cell.detailTField.text = person.email
            
        case 4:
            
            cell.detailLabel.text = "Password"
            cell.detailTField.text = person.password
            cell.detailTField.isSecureTextEntry = true
            
        case 5:
            
            cell.detailLabel.text = "Re-Enter Password"
            cell.detailTField.text = person.password
            cell.detailTField.isSecureTextEntry = true
            
        case 6:
            
            cell.detailLabel.text = "Age"
            cell.detailTField.text = String(person.age)
            cell.detailTField.keyboardType = .numberPad
            
            
        case 7:
            
            cell.detailLabel.text = "Date Of Birth"
            cell.detailTField.text = person.dob
            
        case 8:
            
            cell.detailLabel.text = "Phone No."
            cell.detailTField.text = String(person.phone)
            cell.detailTField.keyboardType = .phonePad
            
            
        default:
            
            cell.detailLabel.text = "Address"
            cell.detailTField.text = person.address
            cell.detailTField.autocapitalizationType = .words
            
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: EditUserDetails - TextField Delegate Methods

extension EditUserVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cell = textField.getTableViewCell else { return }
        let index = editTable.indexPath(for: cell)
        
        switch index!.row {
        case 0:
            
            person.firstName = textField.text!
            print(#function)
            
        case 1:
            
            person.lastName = textField.text!
            print(#function)
            
        case 2:
            
            person.userName = textField.text!
            print(#function)
            
        case 3:
            
            person.email = textField.text!
            print(#function)
            
        case 4:
            
            person.password = textField.text!
            print(#function)
            
        case 5:
            
            if textField.text != person.password {
                //                let alert = UIAlertController(title: "Password Mismatch", message: "Re-Enter Password", preferredStyle: .alert)
                //                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                //                alert.addAction(action)
                //                alert.present(alert, animated: true, completion: { textField.text = "" })
                person.password = ""
            }
            print(#function)
            
        case 6:
            
            person.age = Int(textField.text!)!
            print(#function)
            
        case 7:
            
            person.dob = textField.text!
            print(#function)
            
        case 8:
            
            person.phone = Int64(textField.text!)!
            print(#function)
            
        default:
            
            person.address = textField.text!
            print(#function)
            
        }
    }
    
}
