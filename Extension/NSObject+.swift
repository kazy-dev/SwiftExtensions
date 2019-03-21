//
//  NSObject+.swift
//  sparrow
//
//  Created by Yoshikazu on 2018/12/19.
//  Copyright © 2018 YoshikazuIshii. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// クラス名。
    static var className: String {
        get {
            return String(describing: self)
        }
    }
    
    var className: String {
        get {
            return String(describing: type(of: self))
        }
    }
}
