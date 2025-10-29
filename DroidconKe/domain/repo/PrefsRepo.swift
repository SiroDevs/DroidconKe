//
//  PrefsRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

protocol PrefsRepoProtocol {
    var conTypeSet: Bool { get set }
    var conType: String { get set }
    var conFilter: ConFilter { get set }
    
    func resetPrefs()
}

class PrefsRepo: PrefsRepoProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var conTypeSet: Bool {
        get { userDefaults.bool(forKey: PrefConstants.conTypeSet) }
        set { userDefaults.set(newValue, forKey: PrefConstants.conTypeSet) }
    }
    
    var conType: String {
        get { userDefaults.string(forKey: PrefConstants.conType) ?? PrefConstants.defaultConType }
        set { userDefaults.set(newValue, forKey: PrefConstants.conType) }
    }
    
    var conFilter: ConFilter {
        get {
            let rawValue = userDefaults.string(forKey: PrefConstants.conType) ?? PrefConstants.defaultConType
            return ConFilter(rawValue: rawValue) ?? .all
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: PrefConstants.conType)
            conTypeSet = true
        }
    }
    
    func resetPrefs() {
        conType = PrefConstants.defaultConType
        conTypeSet = false
    }
}
