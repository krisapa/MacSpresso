//
//  SettingsModel.swift
//  MacSpresso
//
//  Created by 6b70 on 9/8/24.
//

import Foundation

class AppSettings: ObservableObject {
    
    public enum Keys {
           static let preventDisplaySleep = "preventDisplaySleep"
           static let preventSystemSleep = "preventSystemSleep"
           static let preventDiskSleep = "preventDiskSleep"
       }
    
    static let shared = AppSettings()
    static let settingsChanged = Notification.Name("AppSettingsChanged")

    @Published var preventDisplaySleep: Bool {
        didSet {
            UserDefaults.standard.set(preventDisplaySleep, forKey: "preventDisplaySleep")
            postSettingsChanged()
        }
    }
    
    @Published var preventSystemSleep: Bool {
        didSet {
            UserDefaults.standard.set(preventSystemSleep, forKey: "preventSystemSleep")
            postSettingsChanged()
        }
    }
    
    @Published var preventDiskSleep: Bool {
        didSet {
            UserDefaults.standard.set(preventDiskSleep, forKey: "preventDiskSleep")
            postSettingsChanged()
        }
    }

    init() {
        let defaults = UserDefaults.standard
           defaults.register(defaults: [
            Keys.preventDisplaySleep: true,
            Keys.preventSystemSleep: true,
            Keys.preventDiskSleep: true
           ])
        self.preventDisplaySleep = UserDefaults.standard.bool(forKey: Keys.preventDisplaySleep)
        self.preventSystemSleep = UserDefaults.standard.bool(forKey: Keys.preventSystemSleep)
        self.preventDiskSleep = UserDefaults.standard.bool(forKey: Keys.preventDiskSleep)
    }
  

    public func postSettingsChanged() {
        NotificationCenter.default.post(name: AppSettings.settingsChanged, object: nil)
    }
}

