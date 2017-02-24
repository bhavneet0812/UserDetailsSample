//
//  UserDetailVC.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {
    
    let UserDetailCell = Xib(name: "UserDetailCell", id: "UserDetailCellID")
    
    @IBOutlet weak var userDetailNavigation: UINavigationItem!
    
    @IBOutlet weak var userDetailsTable: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        userDetailsTable.delegate = self
        userDetailsTable.dataSource = self
        
        let userDetailCellNib = UINib(nibName: UserDetailCell.name, bundle: nil)
        userDetailsTable.register(userDetailCellNib, forCellReuseIdentifier: UserDetailCell.id)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        
    }
    
}


extension UserDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.id, for: indexPath) as? UserDetailCell else { fatalError("Error while dequeue table cell.") }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
