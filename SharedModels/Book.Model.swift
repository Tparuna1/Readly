//
//  Book.Model.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation

// MARK: - Book Status Enum
enum BookStatus: String, CaseIterable, Codable {
    case read = "Read"
    case currentlyReading = "Currently Reading"
    case wantToRead = "Want to Read"
}

// MARK: - Book Model
struct Book: Identifiable, Codable {
    let id: UUID
    var title: String
    var author: String
    var status: BookStatus
    var readingProgress: Double
    var totalPages: Int
    var readPages: Int
    var deletedDate: Date?
    var coverImageData: Data?
    var notes: String

    // MARK: - Initializer
    init(id: UUID = UUID(), title: String, author: String, status: BookStatus, totalPages: Int = .zero, readPages: Int = .zero, readingProgress: Double = 0.0, deletedDate: Date? = nil, coverImageData: Data? = nil, notes: String = "") {
        self.id = id
        self.title = title
        self.author = author
        self.status = status
        self.totalPages = totalPages
        self.readPages = readPages
        self.readingProgress = readingProgress
        self.deletedDate = deletedDate
        self.coverImageData = coverImageData
        self.notes = notes
    }
}
