//
//  StatussPickerView.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

struct StatusPickerView: View {
    @Binding var selectedStatus: BookStatus
    
    var body: some View {
        Picker("Status", selection: $selectedStatus) {
            ForEach(BookStatus.allCases, id: \.self) { status in
                Text(status.rawValue).tag(status)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
