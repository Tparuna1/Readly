//
//  PersistenceService.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import Foundation

class PersistenceService {
    static let shared = PersistenceService()
    private let fileName = "books.json"
    
    private var fileURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(fileName)
    }
    
    func saveBooks(_ books: [Book]) {
        do {
            let data = try JSONEncoder().encode(books)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save books: \(error.localizedDescription)")
        }
    }
    
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
