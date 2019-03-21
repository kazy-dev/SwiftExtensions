//
//  UITextField+.swift
//  sparrow
//
//  Created by Yoshikazu on 2019/02/21.
//  Copyright © 2019 YoshikazuIshii. All rights reserved.
//

import Foundation

extension UITextField {
    
    /// 入力制限フィルターを行う。
    ///
    /// - Parameter limit: 入力上限
    /// - Returns: フィルター後のテキスト
    @discardableResult
    func filterLength(limit: Int) -> String {
        var resultText = ""
        guard let text = self.text else {
            return resultText
        }
        resultText = text
        if text.count >= limit {
            let strSequence = text[..<text.index(text.startIndex, offsetBy: limit)]
            self.text = String(strSequence)
            resultText = String(strSequence)
        }
        return resultText
    }
}
