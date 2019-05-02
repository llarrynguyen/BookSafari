//
//  PromoContentViewController.swift
//  Pirate Bay
//
//  Created by Larry Nguyen on 12/28/16.
//  Copyright © 2016 Larry. All rights reserved.
//

import UIKit

class PromoContentViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var promoImageView: UIImageView!
    
    
    // MARK: - Properties
    
    var pageIndex = 0
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentImage = imageName {
            promoImageView.image = UIImage(named: currentImage)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
