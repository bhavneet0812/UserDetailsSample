//
//  Extensions.swift
//  UserDetails
//
//  Created by Appinventiv on 24/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

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
