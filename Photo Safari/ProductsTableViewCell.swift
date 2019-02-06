//
//  ProductsTableViewCell.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 1/2/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var userRating: UserRating!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    internal func configureCell(with product: Product) {
        productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
        productNameLabel.text = product.name
        manufacturerLabel.text = product.manufacturer?.name
        priceLabel.text = product.salePrice.currencyFormatter
        userRating.rating = Int(product.rating)
    }
}
