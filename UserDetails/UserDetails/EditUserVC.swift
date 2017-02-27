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
        
        if let x = editIndex {
        updateData(index: x)
        let _ = navigationController?.popViewController(animated: true)
        }
        
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
        object.age = Int32(editData.age)
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
            cell.detailTField.text = editData.firstName
            cell.detailTField.autocapitalizationType = .words
            
        case 1:
            
            cell.detailLabel.text = "Last Name"
            cell.detailTField.text = editData.lastName
            cell.detailTField.autocapitalizationType = .words
            
        case 2:
            
            cell.detailLabel.text = "Username"
            cell.detailTField.text = editData.userName
            
        case 3:
            
            cell.detailLabel.text = "Email"
            cell.detailTField.text = editData.email
            
        case 4:
            
            cell.detailLabel.text = "Password"
            cell.detailTField.text = editData.password
            cell.detailTField.isSecureTextEntry = true
            
        case 5:
            
            cell.detailLabel.text = "Re-Enter Password"
            cell.detailTField.text = editData.password
            cell.detailTField.isSecureTextEntry = true
            
        case 6:
            
            cell.detailLabel.text = "Age"
            cell.detailTField.text = String(editData.age)
            cell.detailTField.keyboardType = .numberPad
            
            
        case 7:
            
            cell.detailLabel.text = "Date Of Birth"
            cell.detailTField.text = editData.dob
            
        case 8:
            
            cell.detailLabel.text = "Phone No."
            cell.detailTField.text = String(editData.phone)
            cell.detailTField.keyboardType = .phonePad
            
            
        default:
            
            cell.detailLabel.text = "Address"
            cell.detailTField.text = editData.address
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
            
            editData.firstName = textField.text!
            print(#function)
            
        case 1:
            
            editData.lastName = textField.text!
            print(#function)
            
        case 2:
            
            editData.userName = textField.text!
            print(#function)
            
        case 3:
            
            editData.email = textField.text!
            print(#function)
            
        case 4:
            
            editData.password = textField.text!
            print(#function)
            
        case 5:
            
            if textField.text != editData.password {
                //                let alert = UIAlertController(title: "Password Mismatch", message: "Re-Enter Password", preferredStyle: .alert)
                //                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                //                alert.addAction(action)
                //                alert.present(alert, animated: true, completion: { textField.text = "" })
                editData.password = ""
            }
            print(#function)
            
        case 6:
            
            editData.age = Int(textField.text!)!
            print(#function)
            
        case 7:
            
            editData.dob = textField.text!
            print(#function)
            
        case 8:
            
            editData.phone = Int64(textField.text!)!
            print(#function)
            
        default:
            
            editData.address = textField.text!
            print(#function)
            
        }
    }
    
}
