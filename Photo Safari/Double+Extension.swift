//
//  Double+Extension.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 1/2/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var percentFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
