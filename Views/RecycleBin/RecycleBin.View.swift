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
        NavigationStack {
            List {
                ForEach(viewModel.books.filter { $0.deletedDate != nil }) { book in
                    NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, isFromRecycleBin: true)) {
                        BookCardView(book: book)
                    }
                }
            }
            .navigationTitle("Recycle Bin")
        }
    }
}
