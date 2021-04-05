//
//  ProductsViewController.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var productsTableView: UITableView! {
        didSet {
            self.setupTableView()
        }
    }
    private let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getProducts()
        self.viewModel.completionHandler = {
            self.productsTableView.reloadData()
        }
        self.viewModel.completionHandlerWithMassage = {
            msg in
            self.showToast(message: msg)
        }
    }
    
    func setupTableView() {
        self.productsTableView.dataSource = self
        

        self.productsTableView.registerCell(nibName: "ProductTableViewCell", forCellReuseIdentifier: String(describing: ProductTableViewCell.self))
    }
}

extension ProductsViewController: UITableViewDataSource, ProductTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProductTableViewCell", for: indexPath) as? ProductTableViewCell
        cell?.product = self.viewModel.getProductByIndex(indexPath.item)
        cell?.delegate = self
        return cell ??  UITableViewCell()
    }
    
    func didAddProductToCard(_ product: Product) {
        self.viewModel.addProductToCart(product)
    }
    
}
