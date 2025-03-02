//
//  Book.Model.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation

enum BookStatus: String, CaseIterable, Codable {
    case read = "Read"
    case currentlyReading = "Currently Reading"
    case wantToRead = "Want to Read"
}

struct Book: Identifiable, Codable {
    let id: UUID
    var title: String
    var author: String
    var status: BookStatus
    var readingProgress: Double
    var deletedDate: Date?
    var coverImageData: Data?
    var notes: String

    init(id: UUID = UUID(), title: String, author: String, status: BookStatus, readingProgress: Double = 0.0, deletedDate: Date? = nil, coverImageData: Data? = nil, notes: String = "") {
        self.id = id
        self.title = title
        self.author = author
        self.status = status
        self.readingProgress = readingProgress
        self.deletedDate = deletedDate
        self.coverImageData = coverImageData
        self.notes = notes
    }
}
