//
//  CodableHandeler.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation
import SwiftyJSON
struct CodableHandler {
    static func decode<T : Decodable>(_ type: T.Type, from jsonData: Data) -> Any? {
        do {
            let jsonDecoder = JSONDecoder()
            let contactModel = try jsonDecoder.decode( type,from: jsonData )
            return contactModel
        } catch let caught as NSError {
            dLog(caught)
            return nil
        }
    }
}
