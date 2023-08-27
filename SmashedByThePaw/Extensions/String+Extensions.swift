//
//  String+Extensions.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

extension String {
    func asDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: self)
    }
}
