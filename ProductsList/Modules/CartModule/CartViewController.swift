//
//  CartViewController.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var cartItemTableView: UITableView! {
        didSet {
            self.setupTableView()
        }
    }
    private let viewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getProducts()
        self.viewModel.completionHandler = {
            self.cartItemTableView.reloadData()
        }
        self.viewModel.completionHandlerWithMassage = {
            msg in
            self.showToast(message: msg)
            self.cartItemTableView.reloadData()
        }
    }
    
    func setupTableView() {
        self.cartItemTableView.dataSource = self
        self.cartItemTableView.registerCell(nibName: "ProductTableViewCell", forCellReuseIdentifier: String(describing: ProductTableViewCell.self))
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProductTableViewCell", for: indexPath) as? ProductTableViewCell
        cell?.product = self.viewModel.getProductByIndex(indexPath.item)
        cell?.addToCartButton.isHidden = true
        return cell ??  UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteProduct(product: self.viewModel.getProductByIndex(indexPath.item))
        }
    }
}
