//
//  BookDetailView.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @State private var book: Book
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    var isFromRecycleBin: Bool = false

    init(book: Book, viewModel: LibraryViewModel, isFromRecycleBin: Bool = false) {
        self.viewModel = viewModel
        self._book = State(initialValue: book)
        self.isFromRecycleBin = isFromRecycleBin
    }

    var body: some View {
        NavigationStack {
            ZStack {
                (viewModel.isDarkMode ? Color.darkBlue : Color.cottonWhite)
                    .ignoresSafeArea()

                VStack {
                    TitleView(title: LocalizedStrings.Book.BookDetails.title)
                    
                    Form {
                        TextField(LocalizedStrings.Book.Title.text, text: $book.title)
                            .foregroundColor(viewModel.isDarkMode ? .cottonWhite : .darkBlue)
                        TextField(LocalizedStrings.Book.Author.text, text: $book.author)
                            .foregroundColor(viewModel.isDarkMode ? .cottonWhite : .darkBlue)

                        Picker(LocalizedStrings.Components.Status.text, selection: $book.status) {
                            ForEach(BookStatus.allCases, id: \.self) { status in
                                Text(status.rawValue).tag(status)
                            }
                        }
                        .onChange(of: book.status) { _ in
                            viewModel.updateBook(book)
                        }

                        Section(header: Text(LocalizedStrings.Components.ReadingProgress.text)) {
                            if book.totalPages > .zero {
                                Text("\(LocalizedStrings.Book.TotalPages.text) \(book.totalPages)")
                                    .font(.caption)
                                    .foregroundColor(.spaceGrey)

                                TextField(LocalizedStrings.Book.ReadPages.text, value: $book.readPages, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .onChange(of: book.readPages) { _ in
                                        book.readingProgress = (Double(book.readPages) / Double(book.totalPages)) * 100
                                        viewModel.updateBook(book)
                                    }

                                Text("\(Int(book.readingProgress))%  \(LocalizedStrings.Components.Completed.text)")
                                    .font(.caption)
                                    .foregroundColor(.spaceGrey)
                            }
                        }

                        Section(header: Text(LocalizedStrings.Book.Notes.text)) {
                            TextEditor(text: $book.notes)
                                .frame(minHeight: Grid.Size.small.height)
                                .padding(Grid.Spacing.xs3)
                                .cornerRadius(Grid.Spacing.xs)
                                .onChange(of: book.notes) { _ in
                                    viewModel.updateBook(book)
                                }
                        }

                        if isFromRecycleBin {
                            Section {
                                Button(LocalizedStrings.Book.RestoreBook.button) {
                                    viewModel.restoreBook(book)
                                    dismiss()
                                }
                                .foregroundColor(.darkGreen)
                            }
                        } else {
                            Section {
                                Button(LocalizedStrings.Book.MoveToRecycleBin.button) {
                                    viewModel.moveToRecycleBin(book)
                                    dismiss()
                                }
                                .foregroundColor(.darkRed)
                            }
                        }
                    }
                    .background(viewModel.isDarkMode ? Color.darkBlue : Color.cottonWhite)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
