//
//  RecycleBin.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct RecycleBinView: View {
    @ObservedObject var viewModel: LibraryViewModel

    var body: some View {
        List {
            ForEach(viewModel.books.filter { $0.deletedDate != nil }) { book in
                HStack {
                    BookCardView(book: book)

                    Spacer()

                    Button(action: {
                        viewModel.restoreBook(book)
                    }) {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .foregroundColor(.blue)
                    }

                    Button(action: {
                        viewModel.permanentlyDeleteBook(book)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Recycle Bin")
    }
}
