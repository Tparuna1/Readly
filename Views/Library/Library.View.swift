//
//  Library.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

// MARK: - LibraryView
/// Main view for displaying different book categories (Currently Reading, Want to Read, Read)

struct LibraryView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: LibraryViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var navigateToAddBook = false

    // MARK: - Layout
    private let columns = [
        GridItem(.flexible(), spacing: Grid.Spacing.m),
        GridItem(.flexible(), spacing: Grid.Spacing.m)
    ]

    var body: some View {
        NavigationStack {
            // MARK: - Background and Title
            ZStack {
                (colorScheme == .dark ? Color.darkBlue : Color.cottonWhite)
                    .ignoresSafeArea()

                VStack {
                    TitleView(title: LocalizedStrings.Book.MyLibrary.title)

                    // MARK: - Book Sections
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
            // MARK: - Toolbar Actions
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: viewModel.toggleDarkMode) {
                        Image(systemName: viewModel.isDarkMode ? Image.sunMaxFill : Image.moonFill)
                            .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        navigateToAddBook = true
                    } label: {
                        Image.plus
                            .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                    }
                }
            }
            // MARK: - Navigation to Add Book
            .navigationDestination(isPresented: $navigateToAddBook) {
                AddBookView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Section View for Book Categories
    @ViewBuilder
    private func sectionView(title: String, books: [Book]) -> some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
            .padding(.horizontal)

        if books.isEmpty {
            // MARK: - Placeholder View for Empty Sections
            PlaceholderCardView {
                navigateToAddBook = true
            }
        } else {
            // MARK: - Display Books in LazyVGrid
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
