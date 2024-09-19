//
//  CaffeinateManager.swift
//  MacSpresso
//
//  Created by 6b70 on 9/8/24.
//

import Foundation

class CaffeinateManager: ObservableObject {
    static let shared = CaffeinateManager()

    private let caffeinateService = CaffeinateService.shared
    private var timer: Timer?
    
    @Published var elapsedTime = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleSettingsChange), name: AppSettings.settingsChanged, object: nil)
        self.startTimer()
        self.restartCaffeinateProcess()
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.elapsedTime += 1
        }
    }

    @objc func handleSettingsChange() {
        self.restartCaffeinateProcess()
    }

    private func restartCaffeinateProcess() {
        var arguments = [String]()
        
        if AppSettings.shared.preventDisplaySleep {
            arguments.append("-d")
        }
        if AppSettings.shared.preventSystemSleep {
            arguments.append("-s")
        }
        if AppSettings.shared.preventDiskSleep {
            arguments.append("-m")
        }
        
        if arguments.isEmpty {
            arguments.append("-i")
        }
        
        self.elapsedTime = 0
        self.caffeinateService.killCaffeinate()
        self.caffeinateService.startCaffeinate(withOptions: arguments)
    }
    

    deinit {
        self.caffeinateService.killCaffeinate()
        self.timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}
