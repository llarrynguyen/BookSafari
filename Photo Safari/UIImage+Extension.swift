//
//  UIImage+Extension.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 1/5/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
