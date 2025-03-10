//
//  Library.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.colorScheme) var colorScheme

    private let columns = [
        GridItem(.flexible(), spacing: Grid.Spacing.m),
        GridItem(.flexible(), spacing: Grid.Spacing.m)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                (colorScheme == .dark ? Color.darkBlue : Color.cottonWhite)
                    .ignoresSafeArea()

                VStack {
                    TitleView(title: LocalizedStrings.Book.MyLibrary.title)

                    ScrollView {
                        VStack(alignment: .leading, spacing: Grid.Spacing.l) {
                            sectionView(title: LocalizedStrings.Components.CurrentlyReading.text,
                                        books: viewModel.books.filter { $0.status == .currentlyReading && $0.deletedDate == nil })

                            sectionView(title: LocalizedStrings.Components.WantToRead.text,
                                        books: viewModel.books.filter { $0.status == .wantToRead && $0.deletedDate == nil })

                            sectionView(title: LocalizedStrings.Components.Read.text,
                                        books: viewModel.books.filter { $0.status == .read && $0.deletedDate == nil })
                        }
                        .padding(.top)
                    }
                }
            }
            .onAppear {
                viewModel.loadBooks()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: viewModel.toggleDarkMode) {
                        Image(systemName: viewModel.isDarkMode ? "sun.max.fill" : "moon.fill")
                            .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBookView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func sectionView(title: String, books: [Book]) -> some View {
        if !books.isEmpty {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: Grid.Spacing.m) {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel)) {
                        BookCardView(book: book)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
