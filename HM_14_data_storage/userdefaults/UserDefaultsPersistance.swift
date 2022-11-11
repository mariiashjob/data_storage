//
//  UserDefaultsPersistance.swift
//  HM_14_data_storage
//
//  Created by m.shirokova on 08.11.2022.
//

import Foundation

class UserDefaultsPersistance {
    
    static let shared = UserDefaultsPersistance()
    private let defaults = UserDefaults.standard
    private let kFirstNameKey = "UserDefaultsPersistance.kFirstNameKey"
    private let kLastNameKey = "UserDefaultsPersistance.kLastNameKey"
    
    var firstName: String? {
        set { defaults.set(newValue, forKey: kFirstNameKey) }
        get { return defaults.string(forKey: kFirstNameKey) }
    }
    
    var lastName: String? {
        set { defaults.set(newValue, forKey: kLastNameKey) }
        get { return defaults.string(forKey: kLastNameKey) }
    }
}
