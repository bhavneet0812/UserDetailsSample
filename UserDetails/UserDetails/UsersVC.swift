//
//  UsersVC.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import CoreData

class UsersVC: UIViewController {
    
// MARK: Variables
    
    let UserCell = Xib(name: "UserCell", id: "UserCellID")
    
    let dbHelper = DBHelper()
    
    let userDetailVC = UserDetailVC()
    
    let editUserVC = EditUserVC()
    

// MARK: IBOutlets

    @IBOutlet weak var usersTable: UITableView!

// MARK: UsersVC Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.delegate = self
        usersTable.dataSource = self

        let usersCell = UINib(nibName: UserCell.name, bundle: nil)
        usersTable.register(usersCell, forCellReuseIdentifier: UserCell.id)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        dbHelper.getData()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide Keyboard
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: OperationQueue.main, using: {(Notification) -> Void in
            
            guard let keyboardHeight = (Notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
                else
            {return}
            
            self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667 - keyboardHeight)
            //self.bottomLayout.constant = keyboardHeight
            
        })
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: {(Notification) -> Void in
            
            self.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667 )
            //self.bottomLayout.constant = 0
            
        })
    
        // Fetch Data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        
        do {
            
            userDetailVC.users = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        usersTable.reloadData()
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

// MARK: userTable - Delegate and Datasource Methods

extension UsersVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailVC.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id, for: indexPath) as? UserCell else { fatalError("Error while dequeue table cell.") }
        
        cell.userNameLabel.text = userDetailVC.users[indexPath.row].firstName! + userDetailVC.users[indexPath.row].lastName!
        cell.emailLabel.text = userDetailVC.users[indexPath.row].email
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default,
                                          title: "Delete",
                                          handler: {(UITableViewRowAction, indexPath) -> Void in
                                            
                                            self.userDetailVC.users.remove(at: indexPath.row)
                                            tableView.deleteRows(at: [indexPath], with: .fade)
                                            
                                            let moc = self.getContext()
                                            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                                            
                                            let result = try? moc.fetch(fetchRequest)
                                            let resultData = result as! [User]
                                            
                                            let object = resultData[indexPath.row]
                                            
                                            moc.delete(object)
                                            
                                            do {
                                                try moc.save()
                                                print("saved!")
                                            } catch let error as NSError  {
                                                print("Could not save \(error), \(error.userInfo)")
                                            } catch {
                                                
                                            }
                                            
                                            
        })
        
        let edit = UITableViewRowAction(style: .default, title: "Edit",
                                        handler: {(UITableViewRowAction, indexPath) -> Void in
                                            
                                            let row = indexPath.row
                                            
                                            let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditUserID") as? EditUserVC
                                            
                                            editVC?.person = self.dbHelper.users[row]
                                            
                                            self.navigationController?.pushViewController(editVC!, animated: true)
                                            
                                            editVC?.personIndex = row
                                            
                                            editVC?.dbHelper = self.dbHelper
                                        
                                            
 
                                            
                                            
                                            
        })
        
        return [delete, edit]

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.editUserVC.text = .no
        
        let row = indexPath.row
        
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditUserID") as? EditUserVC
    
        editVC?.person = dbHelper.users[row]
        
        self.navigationController?.pushViewController(editVC!, animated: true)
        
    }

}
