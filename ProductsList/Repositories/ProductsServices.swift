//
//  ProductsServices.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation
struct ProductsServices {
    
    func get(result:@escaping(_ result : [Product]?, _ error : Error?)->()) {
        let productsData = readLocalProducts(forName: Configure.shared.jsonProuctsFileName)
        if let products = productsData.0, let productsList = CodableHandler.decode([Product].self, from: products) as? [Product] {
            result(productsList, productsData.1)
            return
        }
        result(nil, productsData.1)
    }

    private func readLocalProducts(forName name: String) -> (Data?, Error?) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return (jsonData, nil)
            }
        } catch {
            print(error.localizedDescription)
            return (nil, error)
        }
        
        return (nil, nil)
    }
}
