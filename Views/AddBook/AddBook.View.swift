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
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)

                Picker("Status", selection: $status) {
                    ForEach(BookStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }

                Section(header: Text("Book Cover")) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    }

                    Button("Select Cover Image") {
                        showImagePicker = true
                    }
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let newBook = Book(
                            title: title,
                            author: author,
                            status: status,
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
