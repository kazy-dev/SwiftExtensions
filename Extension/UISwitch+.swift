//
//  UISwitch+.swift
//  sparrow
//
//  Created by Yoshikazu on 2019/02/04.
//  Copyright © 2019 YoshikazuIshii. All rights reserved.
//

import Foundation
import UIKit

extension UISwitch {
    
    open override func layoutSubviews() {
        self.layer.cornerRadius =  self.frame.size.height / 2
    }
}
