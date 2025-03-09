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

    private let columns = [
        GridItem(.flexible(), spacing: Grid.Spacing.m),
        GridItem(.flexible(), spacing: Grid.Spacing.m)
    ]

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

                ScrollView {
                    if viewModel.books.filter({ $0.deletedDate != nil }).isEmpty {
                        Text("No books in the Recycle Bin")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: Grid.Spacing.m) {
                            ForEach(viewModel.books.filter { $0.deletedDate != nil }) { book in
                                VStack {
                                    ZStack(alignment: .topTrailing) {
                                        NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, isFromRecycleBin: true, progress: book.readingProgress / 100)) {
                                            BookCardView(book: book)
                                        }

                                        if isSelecting {
                                            Image(systemName: selectedBooks.contains(book.id) ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(selectedBooks.contains(book.id) ? .blue : .gray)
                                                .padding(Grid.Spacing.xs2)
                                                .onTapGesture {
                                                    toggleSelection(for: book)
                                                }
                                        }
                                    }

                                    if let deletedDate = book.deletedDate {
                                        let remainingDays = viewModel.daysUntilDeletion(for: book)
                                        Text("Permanently deleted in \(remainingDays) day\(remainingDays == 1 ? "" : "s")")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        .padding()
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
