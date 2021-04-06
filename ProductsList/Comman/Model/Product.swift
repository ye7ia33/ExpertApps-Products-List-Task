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
    
    //MARK: INIT EMPTY `PRODCTS` OBJECT
    init() {
        self.id = -1
        self.name = ""
    }
    
    init(dic: [String: Any]) {
        guard let id = dic["id"] as? Int, let name = dic["name"] as? String else {
            return
        }
        self.id = id
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    //MARK: USE IT FOR SAVE `PRODCTS` ITNO COREDATA
    func getArray() -> [String: Any] {
        return ["id": self.id ?? -1, "name": name ?? "", "date": Date()]
    }
}
