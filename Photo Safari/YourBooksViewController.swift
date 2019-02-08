//
//  YourBooksViewController.swift
//  Photo Safari
//
//  Created by Larry Nguyen on 2/7/19.
//  Copyright © 2019 devhubs. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    let cellsPerRow: Int
    
    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()
        
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        var marginsAndInsets: CGFloat = 0
        guard let collectionView = collectionView else { return }
        if #available(iOS 11.0, *) {
            marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        } else {
            marginsAndInsets = 0
        }
        
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}

class YourBooksViewController: UIViewController {
    
    var yourProductArray: [Product] = []
    
    var yourProductIds: [String] = []
    
    var selectedProduct: Product? = nil

    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var yourCollectionView: UICollectionView!
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let lovedIds = userDefaults.value(forKey: ProductDetailConstant.lovedArrayIdKey) as? [String] {
            self.yourProductIds = lovedIds
            self.yourProductArray = ProductService.products(with: lovedIds)
            DispatchQueue.main.async {
                self.yourCollectionView.reloadData()
            }
        }
    }
    
    func setUpCollectionView(){
        self.yourCollectionView.delegate = self
        self.yourCollectionView.dataSource = self
        self.yourCollectionView.collectionViewLayout = columnLayout
        self.yourCollectionView.contentInsetAdjustmentBehavior = .always
    }
    
    
    
    func dismissItem() -> (() ->()) {
        return { [weak self] in
            if let array = self?.yourProductArray, let select = self?.selectedProduct {
                var set = Set(array)
                set.remove(select)
                self?.userDefaults.set(Array(set), forKey: ProductDetailConstant.lovedArrayIdKey)
                DispatchQueue.main.async {
                    self?.yourCollectionView.reloadData()
                }
            }
          
        }
    }

}


extension YourBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (yourProductArray.count == 0) {
            self.yourCollectionView.setEmptyMessage("You have not add any book into collection")
        } else {
            self.yourCollectionView.restore()
        }

        return yourProductArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yourcell", for: indexPath) as? YourCollectionViewCell {
            let product = yourProductArray[indexPath.row]
            cell.update(product: product, deleteClosure:self.dismissItem())
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension YourBooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let select = yourProductArray[indexPath.row] as? Product {
            self.selectedProduct = select
        }
    }
}
