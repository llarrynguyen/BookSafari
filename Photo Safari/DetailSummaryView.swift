
import UIKit

class DetailSummaryView: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var userRating: UserRating!
    
    
    // MARK: - Properties

    var buttonContainerView: UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateView(with product: Product) {
        // Make sure no previous view still exists in the current view
        buttonContainerView?.removeFromSuperview()        
        
        // Set default state
        quantityButton.setTitle("Quantity: 1", for: UIControlState.normal)
        quantityButton.isEnabled = true
        quantityButton.alpha = 1.0
        addToCartButton.isEnabled = true
        addToCartButton.alpha = 1.0
        
        // Product Info
        manufacturerLabel.text = product.manufacturer?.name
        productNameLabel.text = product.name
        userRating.rating = Int(product.rating)
        
        let listPriceAttributedString = NSAttributedString(string: product.regularPrice.currencyFormatter, attributes: [NSStrikethroughStyleAttributeName: 1])

        let percenSave = ((product.regularPrice - product.salePrice) / product.regularPrice).percentFormatter
      
        
        if let images = product.productImages {
            let allImages = images.allObjects as! [ProductImage]
            
            if let mainImage = allImages.first {
                productImageView.image = Utility.image(withName: mainImage.name, andType: "jpg")
            }
            
            let imageCount = allImages.count
            var arrButtons = [UIButton]()
            buttonContainerView = UIView()
            
            for x in 0..<imageCount {
                let image = Utility.image(withName: allImages[x].name, andType: "jpg")
                let buttonImage = image?.resizeImage(newHeight: 40.0)
                
                let button = UIButton()
                button.setTitle(allImages[x].name, for: UIControlState.normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.setImage(buttonImage, for: UIControlState.normal)
                button.imageEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
                button.contentMode = .center
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.layer.cornerRadius = 5
                
                if x == 0 {
                    button.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
                }
                else {
                    //  |0| |1|
                    button.frame = CGRect(x: arrButtons[x-1].frame.maxX + 10, y: arrButtons[x-1].frame.minY, width: 50.0, height: 50.0)
                }
                
                arrButtons.append(button)
                
                button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControlEvents.touchUpInside)
                
                buttonContainerView?.addSubview(button)
            }
            
            let containerWidth = imageCount * 50 + (imageCount - 1) * 10
            buttonContainerView?.frame = CGRect(x: 20, y: Int(productImageView.frame.maxY + 10), width: containerWidth, height: 50)
            self.addSubview(buttonContainerView!)
        }
    }
    
    
    func buttonAction(_ sender: UIButton) {
        if let imageName = sender.currentTitle {
            let image = Utility.image(withName: imageName, andType: "jpg")
            productImageView.image = image
            productImageView.contentMode = .scaleAspectFit
        }
    }

}


















