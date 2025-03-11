//
//  PlaceholderCardView.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

/// View Provides Placeholder with button action for empty sections in Library
struct PlaceholderCardView: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: Grid.Spacing.xl, height: Grid.Spacing.xl)
                .foregroundColor(.darkBlue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: Grid.Size.semiMedium.width, height: Grid.Size.medium.height)
        .background(Color.gray.opacity(Grid.Opacity.thin))
        .cornerRadius(Grid.Spacing.s)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, Grid.Spacing.xl)
    }
}
