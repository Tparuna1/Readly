//
//  BookDetail.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

//
//  BookDetail.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @State private var book: Book

    init(book: Book, viewModel: LibraryViewModel) {
        self.viewModel = viewModel
        self._book = State(initialValue: book)
    }

    var body: some View {
        Form {
            TextField("Title", text: $book.title)
            TextField("Author", text: $book.author)

            Picker("Status", selection: $book.status) {
                ForEach(BookStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .onChange(of: book.status) { _ in
                viewModel.updateBook(book)
            }

            Section(header: Text("Reading Progress")) {
                Slider(value: $book.readingProgress, in: 0...100, step: 1)
                    .onChange(of: book.readingProgress) { _ in
                        viewModel.updateBook(book)
                    }
            }

            Section {
                Button("Move to Recycle Bin") {
                    viewModel.moveToRecycleBin(book)
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Book Details")
    }
}
