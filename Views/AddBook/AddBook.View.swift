//
//  AddBook.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LibraryViewModel

    @State private var title = ""
    @State private var author = ""
    @State private var status: BookStatus = .wantToRead
    @State private var totalPages: String = ""
    @State private var readPages: String = "" {
        didSet {
            if let readPagesInt = Int(readPages), readPagesInt > .zero {
                status = .currentlyReading
            } else {
                status = .wantToRead
            }
        }
    }
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                TextField(LocalizedStrings.Book.Title.text, text: $title)
                TextField(LocalizedStrings.Book.Author.text, text: $author)
                
                TextField(LocalizedStrings.Book.TotalPages.text, text: $totalPages)
                    .keyboardType(.numberPad)
                TextField(LocalizedStrings.Book.ReadPages.text, text: $readPages)
                    .keyboardType(.numberPad)
                    .onChange(of: readPages) { _ in
                        if let readPagesInt = Int(readPages), readPagesInt > .zero {
                            status = .currentlyReading
                        } else {
                            status = .wantToRead
                        }
                    }

                Picker(LocalizedStrings.Components.Status.text, selection: $status) {
                    ForEach(BookStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
                .onChange(of: status) { newStatus in
                    status = newStatus
                }

                Section(header: Text(LocalizedStrings.Book.BookCover.text)) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: Grid.Size.medium.height)
                            .cornerRadius(Grid.CornerRadius.medium)
                    }

                    Button(LocalizedStrings.Book.SelectCoverImage.button) {
                        showImagePicker = true
                    }
                }
            }
            .navigationTitle(LocalizedStrings.Book.AddBook.button)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(LocalizedStrings.Book.AddBook.button) {
                        let totalPagesInt = Int(totalPages) ?? .zero
                        let readPagesInt = Int(readPages) ?? .zero
                        
                        let progress = totalPagesInt > .zero ? (Double(readPagesInt) / Double(totalPagesInt)) * 100 : 0.0

                        let newBook = Book(
                            title: title,
                            author: author,
                            status: status,
                            totalPages: totalPagesInt,
                            readPages: readPagesInt,
                            readingProgress: progress,
                            coverImageData: selectedImage?.jpegData(compressionQuality: 0.8)
                        )
                        viewModel.addBook(newBook)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}
