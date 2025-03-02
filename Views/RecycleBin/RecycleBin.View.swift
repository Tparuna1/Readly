//
//  RecycleBin.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct RecycleBinView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @State private var selectedBooks: Set<UUID> = []
    @State private var isSelecting = false

    var body: some View {
        NavigationStack {
            VStack {
                if isSelecting {
                    HStack {
                        Button("\(LocalizedStrings.Book.Restore.button) \(selectedBooks.count)") {
                            restoreSelectedBooks()
                        }
                        .disabled(selectedBooks.isEmpty)
                        .buttonStyle(.borderedProminent)

                        Spacer()

                        Button("\(LocalizedStrings.Book.Delete.button) \(selectedBooks.count)") {
                            deleteSelectedBooks()
                        }
                        .disabled(selectedBooks.isEmpty)
                        .buttonStyle(.bordered)
                        .foregroundColor(.red)
                    }
                    .padding()
                }

                List(selection: $selectedBooks) {
                    ForEach(viewModel.books.filter { $0.deletedDate != nil }) { book in
                        HStack {
                            if isSelecting {
                                Image(systemName: selectedBooks.contains(book.id) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(selectedBooks.contains(book.id) ? .blue : .gray)
                            }
                            NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, isFromRecycleBin: true, progress: book.readingProgress / 100)) {
                                VStack(alignment: .leading) {
                                    BookCardView(book: book)

                                    if book.deletedDate != nil {
                                        let remainingDays = viewModel.daysUntilDeletion(for: book)

                                        Text("Permanently deleted in \(remainingDays) day\(remainingDays == 1 ? "" : "s")")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isSelecting {
                                toggleSelection(for: book)
                            }
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStrings.Book.RecycleBin.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isSelecting ? LocalizedStrings.Components.Cancel.button : LocalizedStrings.Components.Select.button) {
                        isSelecting.toggle()
                        selectedBooks.removeAll()
                    }
                }
            }
        }
    }

    private func toggleSelection(for book: Book) {
        if selectedBooks.contains(book.id) {
            selectedBooks.remove(book.id)
        } else {
            selectedBooks.insert(book.id)
        }
    }

    private func restoreSelectedBooks() {
        for bookId in selectedBooks {
            if let book = viewModel.books.first(where: { $0.id == bookId }) {
                viewModel.restoreBook(book)
            }
        }
        selectedBooks.removeAll()
    }

    private func deleteSelectedBooks() {
        for bookId in selectedBooks {
            if let book = viewModel.books.first(where: { $0.id == bookId }) {
                viewModel.permanentlyDeleteBook(book)
            }
        }
        selectedBooks.removeAll()
    }
}
