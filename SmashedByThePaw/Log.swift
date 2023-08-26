//
//  Log.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation
import OSLog

final class Log {
    static func info(_ message: String) {
        Logger.global.info("\(message)")
    }
    
    static func error(_ message: String) {
        Logger.global.error("❌ Error: \(message)")
    }
    
    static func error(_ error: Error) {
        Logger.global.error("❌ Error: \(error.localizedDescription)")
    }
}

extension Logger {
    enum Category: String {
        case global = "global"
    }
    
    private static var subsystem = "SmashedByThePawLog"

    static let global = Logger(subsystem: subsystem, category: Category.global.rawValue)
}
