//
//  ProductViewModel.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation
protocol ProductTableViewDataDelegate {
    func getProducts()
    func numberOfProducts() -> Int
    func getProductByIndex(_ index: Int) -> Product
    var productsArrayList: [Product]? { get }

}

final class ProductViewModel: ViewModel, ProductTableViewDataDelegate {
    private(set) var productsArrayList: [Product]?

    func getProducts() {
        ProductsServices().get {
            (products, error) in
            if error == nil, products != nil {
                self.productsArrayList = products
                self.completionHandler()
            }
            self.completionHandlerWithMassage("Empty products.")
        }
    }

    func getProductByIndex(_ index: Int) -> Product {
        if (self.productsArrayList?.count ?? 0) > index, let product = self.productsArrayList?[index] {
            return product
        }
        return Product()
    }
    
    func numberOfProducts() -> Int {
        return self.productsArrayList?.count ?? 0
    }
    
    func addProductToCart(_ product: Product) {
        if CartItemsServices.shared.add(product) {
            self.completionHandlerWithMassage("Product Added.")
        } else  {
            self.completionHandlerWithMassage("Product not Added")
        }
    }
        
}
