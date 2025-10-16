//
//  IntToChar.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation

func IntToChar(_ number: Int) -> String {
    // 1 -> A, 2 -> B, 26 -> Z
    guard number >= 1 && number <= 26 else { return "?" }
    let unicode = UnicodeScalar(64 + number)! // 65 = "A"
    return String(unicode)
}
