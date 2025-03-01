//
//  Library.ViewModel.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation
import Combine

class LibraryViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var cancellables = Set<AnyCancellable>()
    
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
            loadBooks()
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
    }
}
