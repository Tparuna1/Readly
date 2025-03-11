//
//  Library.ViewModel.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    @Published var books: [Book] = []
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    // MARK: - Initialization
    init() {
        loadBooks()
    }
    
    // MARK: - Theme Management
    func toggleDarkMode() {
        isDarkMode.toggle()
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }

    // MARK: - Book Management
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

    // MARK: - Recycle Bin Management
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

    // MARK: - Persistence
    private func saveBooks() {
        PersistenceService.shared.saveBooks(books)
    }

    func loadBooks() {
        books = PersistenceService.shared.loadBooks()
        cleanUpRecycleBin()
    }

    // MARK: - Recycle Bin Cleanup
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

    // MARK: - Helper Methods
    func daysUntilDeletion(for book: Book) -> Int {
        guard let deletedDate = book.deletedDate else { return 0 }
        let daysPassed = Calendar.current.dateComponents([.day], from: deletedDate, to: Date()).day ?? 0
        return max(0, 30 - daysPassed)
    }
}
