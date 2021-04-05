//
//  CartItemsServices.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//
import Foundation
import SwiftyJSON

struct CartItemsServices {
    static var shared = CartItemsServices()
    private var cartItemList: [Product]?
    
    private init() {
        if cartItemList == nil {
            self.cartItemList = self.getProductsFromLocalDB()
        }
    }
    
    mutating func get() -> [Product] {
        if let prodList = getProductsFromLocalDB() {
            self.cartItemList = prodList
        }
        return self.cartItemList ?? []
    }
    
    private mutating func getProductsFromLocalDB() -> [Product]? {
        guard let productsJson = CoreDataHandler.shared.featchData(entityName: Configure.shared.productsEntityName) else {
            return []
        }
        self.cartItemList = [Product]()
        for element in productsJson {
            guard let id = element["id"] as? Int,
                  let name = element["name"] as? String,
                  let nsDate = element["date"] as? NSDate
            else { continue }
            let prod = Product(id: id, name: name)
            
            let prodDate = nsDate.toDate()
            let nextDaysChacker = prodDate.addingTimeInterval(Configure.shared.productScopeAtCart)
            dLog("prodDate \(prodDate)")
            dLog("nextDaysChacker \(nextDaysChacker)")
            if nextDaysChacker >= Date() {
                self.cartItemList?.append(prod)
            } else {
               _ = self.delete(prod)
            }
        }
        return cartItemList
    }
    
    func add(_ product: Product) -> Bool {
        _ = self.delete(product)
        return CoreDataHandler.shared.add(entityName: Configure.shared.productsEntityName, entityData: product.getArray())
    }
    
    func delete(_ product: Product) -> Bool {
        guard let id = product.id else { return false }
        return CoreDataHandler.shared.delete(entityName: Configure.shared.productsEntityName, whereQuery: "id==\(id)")
    }

}

