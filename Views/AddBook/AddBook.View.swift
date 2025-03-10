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

    @State private var showAlert = false

    var body: some View {
        ZStack {
            (viewModel.isDarkMode ? Color.darkBlue : Color.cottonWhite)
                .ignoresSafeArea()

            VStack {
                TitleView(title: LocalizedStrings.Book.AddBook.button)

                BookFormView(title: $title, author: $author, totalPages: $totalPages, readPages: $readPages, status: $status, selectedImage: $selectedImage, showImagePicker: $showImagePicker)
                
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(LocalizedStrings.Book.AddBook.button) {
                            if title.isEmpty || author.isEmpty || totalPages.isEmpty {
                                showAlert = true
                            } else {
                                let totalPagesInt = Int(totalPages) ?? .zero
                                let readPagesInt = Int(readPages) ?? .zero
                                
                                let progress = totalPagesInt > .zero ? (Double(readPagesInt) / Double(totalPagesInt)) * 100 : 0.0

                                let finalImage = selectedImage?.resize(targetHeight: Grid.Size.mediumLarge.height)

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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(LocalizedStrings.Components.MissingInformation.title), message: Text(LocalizedStrings.Components.MissingInformation.text), dismissButton: .default(Text(LocalizedStrings.Components.Ok.button)))
        }
    }
}
