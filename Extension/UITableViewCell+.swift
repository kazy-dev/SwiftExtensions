//
//  UITableViewCell+.swift
//  sparrow
//
//  Created by Yoshikazu on 2018/12/30.
//  Copyright © 2018 YoshikazuIshii. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
}
