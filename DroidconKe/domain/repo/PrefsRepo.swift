//
//  PrefsRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

protocol PrefsRepoProtocol {
    var eventType: String { get set }
    
    func resetPrefs()
}

class PrefsRepo: PrefsRepoProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var eventType: String {
        get { userDefaults.string(forKey: PrefConstants.eventType) ?? PrefConstants.defaultEvent }
        set { userDefaults.set(newValue, forKey: PrefConstants.eventType) }
    }
    
    func resetPrefs() {
//        installDate = ""
    }
    
}
