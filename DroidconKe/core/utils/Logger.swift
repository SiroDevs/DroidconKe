//
//  Logger.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

protocol LoggerProtocol {
    func log(_ message: String)
}

final class Logger: LoggerProtocol {
    func log(_ message: String) {
        print("LOG: \(message)")
    }
}
