//
//  MenuToolButtonView.swift
//  Movies
//
//  Created by Hazim Razak on 19/10/2025.
//

import SwiftUI

struct MenuToolButtonView: View {
    @Binding var sortType: SortType
//    @Binding var listType: ListType

    
    var body: some View {
        Menu {
//            Button {
//                listType = .icons
//            } label: {
//                Image(systemName: listType == .icons ? "square.grid.2x2.fill" : "square.grid.2x2")
//                Text("Icons").fontWeight(listType == .icons ? .bold : .regular)
//            }
//            Button {
//                listType = .list
//            } label: {
//                Image(systemName: listType == .list ? "list.bullet.circle.fill" : "list.bullet")
//                Text("Lists").fontWeight(listType == .list ? .bold : .regular)
//            }
//            Divider()
            Button {
                sortType = .date
            } label: {
                Image(systemName: sortType == .date ? "clock.fill" : "clock")
                Text("Latest (Date)").fontWeight(sortType == .date ? .bold : .regular)
            }
            Button {
                sortType = .title
            } label: {
                Image(systemName: sortType == .title ? "character.square.fill" : "character.square")
                Text("By Name (A-Z)").fontWeight(sortType == .title ? .bold : .regular)
            }
            Button {
                sortType = .rating
            } label: {
                Image(systemName: sortType == .rating ? "star.fill" : "star")
                Text("Ratings").fontWeight(sortType == .rating ? .bold : .regular)
            }
        } label: {
            Image(systemName: "ellipsis")
        }
    }
}

#Preview {
    MenuToolButtonView(sortType: .constant(.date))
}
