//
//  BookWebviewView.swift
//  Movies
//
//  Created by Hazim Razak on 18/10/2025.
//

import SwiftUI
import WebKit

struct BookWebviewView: View {
    let bookingURL = URL(string: "https://www.cathaycineplexes.com.sg/")!

    var body: some View {
        WebView(url: bookingURL)
    }
}

//struct WebsiteView: View {
//    @State var page = WebPage()
//    let bookingURL = URL(string: "https://www.cathaycineplexes.com.sg/")!
//    
//    var body: some View {
//        WebView(page)
//            .onAppear {
//                page.load(URLRequest(url: bookingURL))
//            }
//    }
//}

#Preview {
    BookWebviewView()
//        .navigationTitle(title)
//        .navigationBarTitleDisplayMode(.inline)
}
