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
    
    static func encode<T : Encodable>(_ type: T) -> [String : Any]? {
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(type)
            let jsonEncode =  try JSONSerialization.jsonObject(with: jsonData) //String(data: jsonData, encoding: .utf8) ?? ""
            return jsonEncode as? [String : Any]
        } catch let caught as NSError {
            dLog(caught)
            return nil
        }
        
    }
    
    static func decodeClass<T : Decodable>(_  type: T.Type , classJsonData : JSON) -> Any? {
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: classJsonData.rawData())
        return modelClass ?? nil
    }
}



struct JsonHandler {
    static func jsonToNSData(json: [String : AnyObject]) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}
