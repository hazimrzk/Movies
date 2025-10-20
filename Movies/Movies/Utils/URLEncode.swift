//
//  URLEncode.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation

func urlEncode(_ text: String) -> String {
    return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
}
