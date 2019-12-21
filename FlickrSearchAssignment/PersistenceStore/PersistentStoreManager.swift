//
//  PersistentStoreManager.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation

protocol PersistentStoreManagerProtocol {
    func setObject<T: Codable>(key: String, value: T)
    func getObject<T: Codable>(_ key: String, _ type: T.Type) -> T?
}

/* PersistentStore
 It deals with the persistence store
 */
final class PersistentStoreManager: PersistentStoreManagerProtocol {
    
    static let shared = PersistentStoreManager()
    
    func setObject<T: Codable>(key: String, value: T) {
        guard (objectIsOfType(value as AnyObject, Array<Any>.self) as Bool?)! else {
            UserDefaults.standard.set(value, forKey: key)
            return
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
   func objectIsOfType<T>(_ parameter: AnyObject, _ type: T.Type) -> Bool {
        if parameter is T {
            return true
        } else {
            return false
        }
    }
    
    func getObject<T: Codable>(_ key: String, _ type: T.Type) -> T? {
        
        guard objectIsOfType(UserDefaults.standard.value(forKey: key) as AnyObject, Data.self),
            let data = UserDefaults.standard.value(forKey: key) as! Data? else {
            return UserDefaults.standard.value(forKey: key) as! T?
        }
        guard let object = try? PropertyListDecoder().decode(type, from: data)
        else { return nil }
        return object
    }
    
    func clearData(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}


