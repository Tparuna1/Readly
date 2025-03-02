//
//  Library.ViewModel.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation

class LibraryViewModel: ObservableObject {
    @Published var books: [Book] = []

    init() {
        loadBooks()
    }

    func addBook(_ book: Book) {
        books.append(book)
        saveBooks()
    }

    func updateBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index] = book
            saveBooks()
        }
    }

    func moveToRecycleBin(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].deletedDate = Date()
            saveBooks()
        }
    }

    func restoreBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].deletedDate = nil
            saveBooks()
        }
    }

    func permanentlyDeleteBook(_ book: Book) {
        books.removeAll { $0.id == book.id }
        saveBooks()
    }

    private func saveBooks() {
        PersistenceService.shared.saveBooks(books)
    }

    func loadBooks() {
        books = PersistenceService.shared.loadBooks()
        cleanUpRecycleBin()
    }

    /// Delete books that have been in the recycle bin for more than 30 days
    private func cleanUpRecycleBin() {
        let currentDate = Date()
        books.removeAll { book in
            if let deletedDate = book.deletedDate {
                return Calendar.current.dateComponents([.day], from: deletedDate, to: currentDate).day ?? 0 >= 30
            }
            return false
        }
        saveBooks()
    }

    /// Calculate remaining days before deletion
    func daysUntilDeletion(for book: Book) -> Int {
        guard let deletedDate = book.deletedDate else { return 0 }
        let daysPassed = Calendar.current.dateComponents([.day], from: deletedDate, to: Date()).day ?? 0
        return max(0, 30 - daysPassed)
    }
}
