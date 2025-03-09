//
//  BookCard.View.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct BookCardView: View {
    let book: Book

    var body: some View {
        VStack {
            if let imageData = book.coverImageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            } else {
                Image(systemName: "book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .foregroundColor(.gray)
            }

            Text(book.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)

            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 120)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}
