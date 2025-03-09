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
                    .frame(
                        width: Grid.Size.mediumSmall.width,
                        height: Grid.Size.semiMedium.height
                    )
                    .cornerRadius(Grid.CornerRadius.small)
            } else {
                Image(systemName: "book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: Grid.Size.mediumSmall.width,
                        height: Grid.Size.semiMedium.height
                    )
                    .foregroundColor(.spaceGrey)
            }

            Text(book.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, Grid.Spacing.xs2)

            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            if book.status == .currentlyReading || book.status == .read {
                Text("\(Int(book.readingProgress))% \(LocalizedStrings.Components.Completed.text)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, Grid.Spacing.xs2)
            }
        }
        .frame(width: Grid.Size.mediumSmall.width)
        .padding()
        .background(Color.spaceGrey.opacity(Grid.Opacity.thin))
        .cornerRadius(Grid.Spacing.s)
    }
}
