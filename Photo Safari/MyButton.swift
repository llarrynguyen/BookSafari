//
//  MyButton.swift
//  Pirate Bay
//
//  Created by Larry Nguyen on 1/4/17.
//  Copyright © 2017 Larry. All rights reserved.
//

import UIKit

@IBDesignable
class MyButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
