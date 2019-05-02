//
//  YourCollectionViewCell.swift
//  Photo Safari
//
//  Created by Larry Nguyen on 2/7/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class YourCollectionViewCell: UICollectionViewCell {
    
    var dissmissClosure: (() ->())?
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissAction(_ sender: Any) {
        self.dissmissClosure?()
    }
    
    func update(product: Product, deleteClosure: @escaping () ->()){
        if let image = product.mainImage {
            productImageView.image = UIImage(named:image)
        }
        self.dissmissClosure = deleteClosure
        
    }
    
    func changeButtonState(active: Bool){
        DispatchQueue.main.async {
            self.dismissButton.isHidden = active == true ? false : true
            self.dismissButton.isUserInteractionEnabled = active == true ? true : false
        }
    }
}
