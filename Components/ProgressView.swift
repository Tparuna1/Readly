//
//  ProgressView.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct ReadingProgressView: View {
    let progress: Double
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(height: 8)
                .cornerRadius(4)
                .padding(.vertical, 4)

            Text("\(Int(progress * 100))% Completed")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
