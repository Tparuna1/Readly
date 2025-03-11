//
//  RecycleBin.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

// MARK: - RecycleBinView
/// View for displaying books in the recycle bin, with options to restore or permanently delete them

struct RecycleBinView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: LibraryViewModel
    @State private var selectedBooks: Set<UUID> = []
    @State private var isSelecting = false

    // MARK: - Layout
    private let columns = [
        GridItem(.flexible(), spacing: Grid.Spacing.m),
        GridItem(.flexible(), spacing: Grid.Spacing.m)
    ]

    var body: some View {
        NavigationStack {
            // MARK: - Background and Title
            ZStack {
                (viewModel.isDarkMode ? Color.darkBlue : Color.cottonWhite)
                    .ignoresSafeArea()

                VStack {
                    TitleView(title: LocalizedStrings.Book.RecycleBin.title)
                        
                    // MARK: - Selection Controls
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
                            .foregroundColor(.darkRed)
                        }
                        .padding()
                    }

                    // MARK: - Recycle Bin Content
                    ScrollView {
                        if viewModel.books.filter({ $0.deletedDate != nil }).isEmpty {
                            Text(LocalizedStrings.Book.NoBooksInRecycleBin.text)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            LazyVGrid(columns: columns, spacing: Grid.Spacing.m) {
                                ForEach(viewModel.books.filter { $0.deletedDate != nil }) { book in
                                    VStack {
                                        ZStack(alignment: .topTrailing) {
                                            // MARK: - Book Card and Selection
                                            if !isSelecting {
                                                NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel, isFromRecycleBin: true)) {
                                                    BookCardView(book: book)
                                                }
                                            } else {
                                                BookCardView(book: book)
                                            }

                                            // MARK: - Selection Indicator
                                            if isSelecting {
                                                Image(systemName: selectedBooks.contains(book.id) ? Image.checkmartCircleFill : Image.circle)
                                                    .foregroundColor(selectedBooks.contains(book.id) ? .darkBlue : .spaceGrey)
                                                    .padding(Grid.Spacing.xs2)
                                                    .onTapGesture {
                                                        toggleSelection(for: book)
                                                    }
                                            }
                                        }

                                        // MARK: - Deletion Countdown
                                        if let deletedDate = book.deletedDate {
                                            let remainingDays = viewModel.daysUntilDeletion(for: book)
                                            Text("Permanently deleted in \(remainingDays) day\(remainingDays == 1 ? "" : "s")")
                                                .font(.caption)
                                                .foregroundColor(.darkRed)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                // MARK: - Toolbar Controls
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
    }

    // MARK: - Helper Methods
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
