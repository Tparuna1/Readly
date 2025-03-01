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
                    Section(header: Text("Currently Reading")) {
                        ForEach(viewModel.books.filter { $0.status == .currentlyReading && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }

                if !viewModel.books.filter({ $0.status == .wantToRead && $0.deletedDate == nil }).isEmpty {
                    Section(header: Text("Want to Read")) {
                        ForEach(viewModel.books.filter { $0.status == .wantToRead && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }

                if !viewModel.books.filter({ $0.status == .read && $0.deletedDate == nil }).isEmpty {
                    Section(header: Text("Read")) {
                        ForEach(viewModel.books.filter { $0.status == .read && $0.deletedDate == nil }) { book in
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, progress: book.readingProgress / 100)) {
                                BookCardView(book: book)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Library")
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
