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
    
    private init() { }
    
    mutating func get(result: @escaping(_ result : [Product]?) -> Void ){
        if let prodList = self.getProductsFromLocalDB() {
            result(prodList)
            return
        }
       result(nil)
    }
    
    private mutating func getProductsFromLocalDB() -> [Product]? {
        guard let productsJson = CoreDataHandler.shared.featchData(entityName: Configure.shared.productsEntityName) else {
            return []
        }
        var cartItemList = [Product]()
        for element in productsJson {
            let prod = Product(dic: element)
            if let nsDate = element["date"] as? NSDate, self.checkItemDate(nsDate) {
                cartItemList.append(prod)
            } else {
                _ = self.delete(prod)
            }
        }
        return cartItemList
    }
    
    private func checkItemDate (_ date: NSDate) -> Bool {
        let prodDate = date.toDate()
        let nextDateChacker = prodDate.addingTimeInterval(Configure.shared.productScopeAtCart)
        dLog("prodDate \(prodDate)")
        dLog("nextDateChacker \(nextDateChacker)")
        return nextDateChacker >= Date()
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

