//
//  Utility.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 12/31/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit

class Utility {
    
    class func image(withName name: String?, andType type: String) -> UIImage? {
        let imagePath = Bundle.main.path(forResource: name?.stripFileExtension(), ofType: type)
        
        var image: UIImage?
        if let path = imagePath {
            image = UIImage(contentsOfFile: path)
        }
        
        return image
    }
    
    
    class func currentYear() -> Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(Calendar.Component.year, from: Date())
        
        return currentYear
    }
    
}
