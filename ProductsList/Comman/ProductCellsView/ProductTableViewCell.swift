//
//  ProductTableViewCell.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import UIKit
protocol ProductTableViewCellDelegate {
    func didAddProductToCard(_ product: Product)
}

class ProductTableViewCell: UITableViewCell {
    var delegate: ProductTableViewCellDelegate?
    
    @IBOutlet weak var productInfoLabel: UILabel! {
        didSet {
            self.productInfoLabel.text = ""
        }
    }
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
 
    var product: Product? {
        didSet {
            self.bindViewModel()
        }
    }
    
    private func bindViewModel() {
        let pId = product?.id ?? -1
        let pName = product?.name ?? ""
        self.productInfoLabel.text = pId != -1 ? "#\(product?.id ?? 0) - \(pName)" : pName
    }
    
    @IBAction func addToCartButtonAction(_ sender: Any) {
        guard let product = self.product else {
            self.addToCartButton.isHidden = true
            return
        }
        self.delegate?.didAddProductToCard(product)
    }
}
