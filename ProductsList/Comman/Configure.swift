//
//  Configure.swift
//
//  Created by Yahia El-Dow on 30/03/2021.
//

import Foundation

struct Configure {
    static var shared = Configure()
    private (set) lazy var jsonProuctsFileName = "dummyProductsList"
    private (set) lazy var productsEntityName = "CartItems"
    
    let productScopeAtCart = Double(60*60*(24 * 3))
    // EMPTY IT FOR SINGLTON
   private init() { }
    
}

func dLog(_ val: Any?){
    #if DEBUG
    print(val ?? "PARAMTERS IS NULL")
    #endif
}
