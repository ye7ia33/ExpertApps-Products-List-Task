//
//  Configure.swift
//
//  Created by Yahia El-Dow on 30/03/2021.
//

import Foundation

struct Configure {
    static let shared = Configure()
    private (set) var productsEntityName: String!
    let productScopeAtCart = Double(60*60*(24 * 3))
   private init() {
        if productsEntityName == nil {
            self.productsEntityName = "CartItems"
        }
    }
}

func dLog(_ val: Any?){
    #if DEBUG
    print(val ?? "PARAMTERS IS NULL")
    #endif
}
