//
//  Product.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation

struct Product: Codable {
    var id: Int?
    var name: String?
    
    func getArray() -> [String: Any] {
        return ["id": self.id ?? -1, "name": name ?? "", "date": Date()]
    }
}
