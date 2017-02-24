//
//  UsersVC.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    
    let UserCell = Xib(name: "UserCell", id: "UserCellID")
    
    @IBOutlet weak var usersTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTable.delegate = self
        usersTable.dataSource = self

        let usersCell = UINib(nibName: UserCell.name, bundle: nil)
        usersTable.register(usersCell, forCellReuseIdentifier: UserCell.id)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
}


extension UsersVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id, for: indexPath) as? UserCell else { fatalError("Error while dequeue table cell.") }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
