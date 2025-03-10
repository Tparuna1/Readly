//
//  Form.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 10.03.25.
//

import SwiftUI
import PhotosUI

struct BookFormView: View {
    @Binding var title: String
    @Binding var author: String
    @Binding var totalPages: String
    @Binding var readPages: String
    @Binding var status: BookStatus
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Form {
            TextField(LocalizedStrings.Book.Title.text, text: $title)
                .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)
            TextField(LocalizedStrings.Book.Author.text, text: $author)
                .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)
            
            TextField(LocalizedStrings.Book.TotalPages.text, text: $totalPages)
                .keyboardType(.numberPad)
                .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)
            TextField(LocalizedStrings.Book.ReadPages.text, text: $readPages)
                .keyboardType(.numberPad)
                .onChange(of: readPages) { _ in
                    if let readPagesInt = Int(readPages), readPagesInt > .zero {
                        status = .currentlyReading
                    } else {
                        status = .wantToRead
                    }
                }
                .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)

            Picker(LocalizedStrings.Components.Status.text, selection: $status) {
                ForEach(BookStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)

            Section(header: Text(LocalizedStrings.Book.BookCover.text)
                        .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)) {
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
                .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)
            }
        }
        .background(colorScheme == .dark ? Color.darkBlue : Color.cottonWhite)
        .scrollContentBackground(.hidden)
    }
}
