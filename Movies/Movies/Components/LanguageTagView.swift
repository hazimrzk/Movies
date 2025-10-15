//
//  LanguageTagView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct LanguageTagView: View {
    
    let language: String
    
    init(language: String) {
        self.language = language
    }
    
    var body: some View {
        Text(language)
            .padding(4)
            .foregroundStyle(Color(.gray))
            .font(.footnote)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .border(Color(.gray).opacity(0.3), width: 1)
    }
}

#Preview {
    let language = "en"
    LanguageTagView(language: language)
}
