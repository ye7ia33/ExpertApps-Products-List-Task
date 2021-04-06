//
//  CartViewModel.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation

final class CartViewModel: ViewModel, ProductTableViewDataDelegate {
    private (set) var productsArrayList: [Product]?
    
    func getProducts() {
        CartItemsServices.shared.get(result: {
            products in
            self.productsArrayList = products
            (self.productsArrayList?.count ?? 0) > 1 ? self.completionHandler() : self.completionHandlerWithMassage("Cart is empty.")
        })
    }
    
    func numberOfProducts() -> Int {
        return self.productsArrayList?.count ?? 0
    }
    
    func getProductByIndex(_ index: Int) -> Product {
        return self.productsArrayList?[index] ?? Product()
    }
    
    func deleteProduct(product: Product) {
        if CartItemsServices.shared.delete(product) {
            self.getProducts()
            if let pName = product.name {
                self.completionHandlerWithMassage("\(pName) removed from cart")
            } else  {
                self.completionHandler()
            }
        } else {
            self.completionHandlerWithMassage("Fail.")
        }
    }
}
