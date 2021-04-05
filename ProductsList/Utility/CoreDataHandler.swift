//
//  CoreDataHandler.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import UIKit
import CoreData


struct CoreDataHandler {
    static let shared = CoreDataHandler()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init() { }
    
    func add(entityName : String , entityData : [String : Any] ) -> Bool {
        // Mearge if Duplicated Data
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            let dataInfo = NSManagedObject(entity: entity, insertInto: context)
            dataInfo.setValuesForKeys(entityData)
            if context.hasChanges {
                do {
                    try context.save()
                    return true
                } catch {
                    print("Failed saving")
                }
            }
        }
        return false
    }
    
    func featchData (entityName : String ) -> [[String: Any]]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if let data = result as? [NSManagedObject] {
                let jsonData = self.convertToJSONArray(mangedObjectArray: data)
                return jsonData
            }
        } catch let caught as NSError{
            print("Failed " , caught.localizedDescription)
        }
        return nil
    }
    
    private func convertToJSONArray(mangedObjectArray: [NSManagedObject]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for item in mangedObjectArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
    func delete(entityName : String, whereQuery: String) -> Bool {
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        requestDel.returnsObjectsAsFaults = false
        do {
            requestDel.predicate = NSPredicate.init(format: whereQuery)
            let arrUsrObj = try context.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                dLog(usrObj)
                context.delete(usrObj)
                try context.save()
                return true
            }
        } catch {
            print("Failed")
        }
        return false
    }
}
