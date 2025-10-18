//
//  BottomButtonBar.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import SwiftUI

struct BottomButtonBar: View {
    
    @State var isFavorite = false
    @State var showSheet = false
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
    
    var body: some View {
        
        HStack() {
            Button {
                showSheet = true
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
                        .opacity(0.5)
                        .glassEffect()
                )
            }
            .sheet(isPresented: $showSheet) {
                BookWebviewView()
            }
            Button {
                toggleFavorite() // no Core Data implemented yet
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
            RoundedRectangle(cornerRadius: 16).fill(Color.teal).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.pink).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.blue).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
            RoundedRectangle(cornerRadius: 16).fill(Color.brown).frame(height: 300).padding(.horizontal).padding(.vertical, 4)
        }
    }.safeAreaInset(edge: .bottom){
        BottomButtonBar()
    }
}
