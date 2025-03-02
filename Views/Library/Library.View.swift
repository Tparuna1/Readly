//
//  Library.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: LibraryViewModel

    var body: some View {
        NavigationView {
            List {
                if !viewModel.books.filter({ $0.status == .currentlyReading && $0.deletedDate == nil }).isEmpty {
                    Section(header: Text(LocalizedStrings.Components.CurrentlyReading.text)) {
                        ForEach(viewModel.books.filter { $0.status == .currentlyReading && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }

                if !viewModel.books.filter({ $0.status == .wantToRead && $0.deletedDate == nil }).isEmpty {
                    Section(header: Text(LocalizedStrings.Components.WantToRead.text)) {
                        ForEach(viewModel.books.filter { $0.status == .wantToRead && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }

                if !viewModel.books.filter({ $0.status == .read && $0.deletedDate == nil }).isEmpty {
                    Section(header: Text(LocalizedStrings.Components.Read.text)) {
                        ForEach(viewModel.books.filter { $0.status == .read && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }
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
