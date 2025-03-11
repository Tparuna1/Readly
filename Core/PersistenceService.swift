//
//  PersistenceService.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation

/// A service for persisting book data locally using JSON encoding and decoding.
class PersistenceService {
    
    /// Shared singleton instance.
    static let shared = PersistenceService()
    
    /// File name for storing book data.
    private let fileName = "books.json"

    /// URL of the file in the app's document directory.
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(fileName)
    }

    /// Saves an array of `Book` objects to a JSON file.
    ///
    /// - Parameter books: The books to be saved.
    func saveBooks(_ books: [Book]) {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save books: \(error.localizedDescription)")
        }
    }

    /// Loads books from the stored JSON file.
    ///
    /// - Returns: An array of `Book` objects, or an empty array if loading fails.
    func loadBooks() -> [Book] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([Book].self, from: data)
        } catch {
            print("Failed to load books: \(error.localizedDescription)")
            return []
        }
    }
}
