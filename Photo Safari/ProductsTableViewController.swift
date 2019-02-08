//
//  ProductsTableViewController.swift
//  Pirate Bay
//
//  Created by Andi Setiyadi on 1/2/17.
//  Copyright © 2017 devhubs. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var products: [Product]?
    var selectedProduct: Product?
    weak var delegate: ProductDetailViewController?

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Products"
        
        if let products = self.products, products.count > 0 {
            self.navigationItem.title = (products.first?.type?.uppercased())!
        }
        else {
            self.products = ProductService.browse()
            if let products = self.products {
                selectedProduct = products.first
            }
        }
        
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.products?.removeAll()
        self.selectedProduct = nil
        self.delegate?.product = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = self.products {
            return products.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 70
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductsTableViewCell

        if let currentProduct = self.products?[indexPath.row] {
            if selectedProduct?.id == currentProduct.id {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
                
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = UIColor().pirateBay_brown().cgColor
                
                delegate?.product = selectedProduct
            }
            else {
                cell.contentView.layer.borderWidth = 0
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.configureCell(with: currentProduct)
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        delegate?.product = selectedProduct
        
        tableView.reloadData()
    }
    

}
