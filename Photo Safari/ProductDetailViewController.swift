//
//  ProductDetailViewController.swift
//  Pirate Bay
//
//  Created by Larry Nguyen on 1/4/17.
//  Copyright © 2017 Larry. All rights reserved.
//

import UIKit

struct ProductDetailConstant {
    static let lovedArrayIdKey = "lovedArrayIdKey"
}


class ProductDetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    @IBOutlet weak var productDescriptionImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartItemCountLabel: UILabel!
    @IBOutlet weak var addToCollectionButton: MyButton!
    
    
    let userDefaults = UserDefaults.standard
    var lovedIdsSet = Set<String>()
    
    var isLovedProduct = false
    var currentProductIndex = -1
    
    
    
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
        if let lovedIds = userDefaults.value(forKey: ProductDetailConstant.lovedArrayIdKey) as? Set<String>,  let currentProductId = product?.id {
            self.lovedIdsSet = lovedIds
            if self.lovedIdsSet.contains(currentProductId){
                 self.isLovedProduct = true
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            
            if let lovedIds = userDefaults.value(forKey: ProductDetailConstant.lovedArrayIdKey) as? [String],  let currentProductId = currentProduct.id {
                self.lovedIdsSet = Set(lovedIds)
                if self.lovedIdsSet.contains(currentProductId){
                    self.isLovedProduct = true
                } else {
                    self.isLovedProduct = false
                }
            } else {
                 self.isLovedProduct = false
            }
            
           
            self.changeAddItemButtonState(loved: self.isLovedProduct)
            
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
    
    func changeAddItemButtonState(loved: Bool){
        self.addToCollectionButton.backgroundColor = loved == true ? UIColor.red : UIColor.orange
        let buttonTitle = loved == true ? "In Your Collection" : "Add To Collection"
        self.addToCollectionButton.setTitle(buttonTitle, for: .normal)
    }
    
    func updateTabBadgeCount(count: Int){
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2]
            tabItem.badgeValue = "\(count)"
        }
    }
    

    // MARK: - IBActions
    
    @IBAction func didTapAddToCart(_ sender: MyButton) {
        if let product = product {
            // Reset the quantity
             self.quantity = 1
            isLovedProduct = !isLovedProduct
            if isLovedProduct {
                self.lovedIdsSet.insert(product.id!)
            } else {
                self.lovedIdsSet.remove(product.id!)
            }
            
            userDefaults.set(Array(self.lovedIdsSet), forKey: ProductDetailConstant.lovedArrayIdKey)
            DispatchQueue.main.async {
                self.updateTabBadgeCount(count: self.lovedIdsSet.count)
                self.changeAddItemButtonState(loved: self.isLovedProduct)
                self.detailSummaryView.quantityButton.setTitle("Quantity: 1", for: UIControlState.normal)
               
                
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
















