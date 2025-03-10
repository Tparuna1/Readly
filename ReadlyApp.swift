//
//  ReadlyApp.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

@main
struct ReadlyApp: App {
    @StateObject private var viewModel = LibraryViewModel()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            TabView {
                LibraryView(viewModel: viewModel)
                    .tabItem {
                        Label("Library", systemImage: "book.fill")
                    }

                RecycleBinView(viewModel: viewModel)
                    .tabItem {
                        Label("Recycle Bin", systemImage: "trash.fill")
                    }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
