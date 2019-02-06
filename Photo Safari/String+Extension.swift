//
//  String+Extension.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 12/31/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit

extension String {
    func stripFileExtension() -> String {
        if self.contains(".") {
            // toy.jpg, .png
            return self.substring(to: self.characters.index(of: ".")!)
        }
        return self
    }
    
    func maskedPlustLast4() -> String {
        let last4CardNumber = self.substring(from: self.index(self.endIndex, offsetBy: -4))
        
        return "****\(last4CardNumber)"
    }
}
