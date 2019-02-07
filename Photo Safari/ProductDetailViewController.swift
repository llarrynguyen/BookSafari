//
//  ProductDetailViewController.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 1/4/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    @IBOutlet weak var productDescriptionImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var cartItemCountLabel: UILabel!
    
    
    // MARK: - Properties
    
    var product: Product? {
        didSet {
            if let currentProduct = product {
                self.showDetail(for: currentProduct)
            }
        }
    }
    
    var specifications = [ProductInfo]()
    var quantity = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Private
    
    private func showDetail(for currentProduct: Product) {
        if viewIfLoaded != nil {
            detailSummaryView.updateView(with: currentProduct)
            
            let productInfo = currentProduct.productInfo?.allObjects as! [ProductInfo]
            specifications = productInfo.filter({ $0.type == "specs" })
            
            var description = ""
            for currentInfo in productInfo {
                if let info = currentInfo.info, info.characters.count > 0, currentInfo.type == "description" {
                    description = description + info + "\n\n"
                }
            }
            
            productDescriptionLabel.text = description
            productDescriptionImageView.image = Utility.image(withName: currentProduct.mainImage, andType: "jpg")
            
            tableView.reloadData()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueQuantity":
                let quantityTVC = segue.destination as! QuantityTableViewController
                quantityTVC.delegate = self
            default:
                break
            }
        }
        
    }
    

    // MARK: - IBActions
    
    @IBAction func didTapAddToCart(_ sender: MyButton) {
        if let product = product {
            // Reset the quantity
            self.quantity = 1
            self.detailSummaryView.quantityButton.setTitle("Quantity: 1", for: UIControlState.normal)
            
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Our Apology", message: "This feature will be ready on our next release", preferredStyle: .alert)
                
                let alertActon = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertActon)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
}


// MARK: - UITableviewDatasource

extension ProductDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProductInfo", for: indexPath) as! ProductInfoTableViewCell
        
        cell.productInfo = specifications[indexPath.row]
        
        return cell
    }
}


// MARK: - QuantityPopoverDelegate

extension ProductDetailViewController: QuantityPopoverDelegate {
    func updateProductToBuy(withQuantity quantity: Int) {
        self.quantity = quantity
        detailSummaryView.quantityButton.setTitle("Quantity: \(self.quantity)", for: UIControlState.normal)
    }
}
















