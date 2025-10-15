//
//  PrettyPrint.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation

func printPretty<T: Codable>(_ value: T) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys] // optional
    if let data = try? encoder.encode(value),
       let jsonString = String(data: data, encoding: .utf8) {
        print(jsonString)
    }
}
