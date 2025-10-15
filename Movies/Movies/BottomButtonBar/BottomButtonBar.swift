//
//  BottomButtonBar.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import SwiftUI

struct BottomButtonBar: View {
    
    @State var isFavorite = false
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    var body: some View {
        HStack() {
            Button {
                // action - call a popup sheet
            } label: {
                HStack {
                    Image(systemName: "tag.fill")
                    Text("Book Movie")
                        .fontWeight(.bold)
                        .shadow(radius: 10)
                }
                .padding()
                .padding(.horizontal, 20)
                .foregroundColor(.white)
                .background(
                    Capsule()
//                        .fill(Color.blue)
                        .opacity(0.5)
                        .glassEffect()
                )
            }
            Button {
                toggleFavorite()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .opacity(0.1)
                            .glassEffect()
                    )
            }
        }
        .padding(.horizontal)

    }
}

#Preview {
    ScrollView {
        VStack {
            RoundedRectangle(cornerRadius: 16).fill(Color.gray).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.gray).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.gray).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.gray).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
        }
    }.safeAreaInset(edge: .bottom){
        BottomButtonBar()
    }
}
