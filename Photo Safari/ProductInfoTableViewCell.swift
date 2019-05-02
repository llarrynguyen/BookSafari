//
//  ProductInfoTableViewCell.swift
//  Pirate Bay
//
//  Created by Larry Nguyen on 1/7/17.
//  Copyright © 2017 Larry. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var productSpecLabel: UILabel!
    
    
    // MARK: - Properties
    
    var productInfo: ProductInfo? {
        didSet {
            if let currentInfo = productInfo {
                configureCell(with: currentInfo)
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func configureCell(with productInfo: ProductInfo) {
        infoTitleLabel.text = productInfo.title
        productSpecLabel.text = productInfo.info
    }
}
