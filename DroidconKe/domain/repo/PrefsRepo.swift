//
//  PrefsRepo.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation

protocol PrefsRepoProtocol {
    var installDate: Date { get set }
    
    func resetPrefs()
}

class PrefsRepo: PrefsRepoProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var installDate: Date {
        get { userDefaults.object(forKey: PrefConstants.installDate) as? Date ?? Date() }
        set { userDefaults.set(newValue, forKey: PrefConstants.installDate) }
    }
    
    func resetPrefs() {
//        installDate = ""
    }
    
}
