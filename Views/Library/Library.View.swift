//
//  Library.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: LibraryViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.books.filter({ $0.status == .currentlyReading && $0.deletedDate == nil }).isEmpty {
                        Text(LocalizedStrings.Components.CurrentlyReading.text)
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.books.filter { $0.status == .currentlyReading && $0.deletedDate == nil }) { book in
                                NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                    BookCardView(book: book)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    if !viewModel.books.filter({ $0.status == .wantToRead && $0.deletedDate == nil }).isEmpty {
                        Text(LocalizedStrings.Components.WantToRead.text)
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.books.filter { $0.status == .wantToRead && $0.deletedDate == nil }) { book in
                                NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                    BookCardView(book: book)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    if !viewModel.books.filter({ $0.status == .read && $0.deletedDate == nil }).isEmpty {
                        Text(LocalizedStrings.Components.Read.text)
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.books.filter { $0.status == .read && $0.deletedDate == nil }) { book in
                                NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                    BookCardView(book: book)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle(LocalizedStrings.Book.MyLibrary.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddBookView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadBooks()
        }
    }
}
