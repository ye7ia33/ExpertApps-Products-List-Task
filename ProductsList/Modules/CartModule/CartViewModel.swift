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
        self.productsArrayList = CartItemsServices.shared.get()
        (self.productsArrayList?.count ?? 0) > 1 ? self.completionHandler() : self.completionHandlerWithMassage("Cart is empty.")
    }
    
    func numberOfProducts() -> Int {
        return self.productsArrayList?.count ?? 0
    }
    
    func getProductByIndex(_ index: Int) -> Product {
        return self.productsArrayList?[index] ?? Product()
    }
    
    func deleteProductFromDB(product: Product) {
        if CartItemsServices.shared.delete(product) {
            self.productsArrayList = CartItemsServices.shared.get()
            self.completionHandler()
        } else {
            self.completionHandlerWithMassage("Fail.")
        }
    }
}
