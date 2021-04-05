//
//  ProductsServices.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation
struct ProductsServices {
    
    func get(result:@escaping(_ result : [Product]?, _ errorMessage : Error?)->()) {
        if let productsData = readLocalProducts(forName: "dummyProductsList"),
           let productsList = CodableHandler.decode([Product].self, from: productsData) as? [Product] {
            result(productsList, nil)
        }        
    }

    private func readLocalProducts(forName name: String) -> Data? {

        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
