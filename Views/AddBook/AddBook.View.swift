//
//  AddBook.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI
import PhotosUI

// MARK: - AddBookView
/// View for adding a new book to the library, including form input and image selection.

struct AddBookView: View {
    // MARK: - Properties
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
    @State private var showAlert = false

    var body: some View {
        ZStack {
            // MARK: - Background Color
            (viewModel.isDarkMode ? Color.darkBlue : Color.cottonWhite)
                .ignoresSafeArea()

            VStack {
                // MARK: - Header
                TitleView(title: LocalizedStrings.Book.AddBook.button)

                // MARK: - Book Form
                BookFormView(title: $title, author: $author, totalPages: $totalPages, readPages: $readPages, status: $status, selectedImage: $selectedImage, showImagePicker: $showImagePicker)
                
                .toolbar {
                    // MARK: - Add Book Button
                    ToolbarItem(placement: .primaryAction) {
                        Button(LocalizedStrings.Book.AddBook.button) {
                            if title.isEmpty || author.isEmpty || totalPages.isEmpty {
                                showAlert = true
                            } else {
                                let totalPagesInt = Int(totalPages) ?? .zero
                                let readPagesInt = Int(readPages) ?? .zero
                                
                                let progress = totalPagesInt > .zero ? (Double(readPagesInt) / Double(totalPagesInt)) * 100 : 0.0

                                let finalImage = selectedImage?.resize(targetHeight: Grid.Size.mediumLarge.height)

                                // MARK: - Creating New Book Object
                                let newBook = Book(
                                    title: title,
                                    author: author,
                                    status: status,
                                    totalPages: totalPagesInt,
                                    readPages: readPagesInt,
                                    readingProgress: progress,
                                    coverImageData: finalImage?.jpegData(compressionQuality: 0.8)
                                )
                                viewModel.addBook(newBook)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        .foregroundColor(viewModel.isDarkMode ? Color.cottonWhite : Color.darkBlue)
                    }
                }
            }
        }
        // MARK: - Image Picker
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        // MARK: - Validation Alert
        .alert(isPresented: $showAlert) {
            Alert(title: Text(LocalizedStrings.Components.MissingInformation.title), message: Text(LocalizedStrings.Components.MissingInformation.text), dismissButton: .default(Text(LocalizedStrings.Components.Ok.button)))
        }
    }
}
