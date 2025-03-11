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
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true

    var body: some Scene {
        WindowGroup {
            TabView {
                LibraryView(viewModel: viewModel)
                    .tabItem {
                        Label(LocalizedStrings.Book.MyLibrary.title, systemImage: Image.bookFill)
                    }

                RecycleBinView(viewModel: viewModel)
                    .tabItem {
                        Label(LocalizedStrings.Book.RecycleBin.title, systemImage: Image.trashFill)
                    }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
