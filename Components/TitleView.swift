//
//  TitleView.swift
//  Readly
//
//  Created by tornike <parunashvili on 10.03.25.
//

import SwiftUI

/// Reusable Title component to use for  main Titles of Views
struct TitleView: View {
    var title: String
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(title)
            .font(.largeTitle)
            .bold()
            .foregroundColor(colorScheme == .dark ? Color.cottonWhite : Color.darkBlue)
            .padding(.top, Grid.Spacing.m)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
