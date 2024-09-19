//
//  CaffeinateService.swift.swift
//  MacSpresso
//
//  Created by 6b70 on 9/8/24.
//

import Foundation


class CaffeinateService {
    static let shared = CaffeinateService()
    private var caffeinateProcess: Process?
    
    func startCaffeinate(withOptions options: [String]) {
        let proc = Process()
        proc.launchPath = "/usr/bin/caffeinate"
        proc.arguments = options
        do {
            try proc.run()
            self.caffeinateProcess = proc
        } catch {
            print("Failed to start caffeinate: \(error)")
        }
    }

    func killCaffeinate() {
        self.caffeinateProcess?.terminate()
    }
}
