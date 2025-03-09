// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum LocalizedStrings {
  internal enum Book {
    internal enum AddBook {
      /// Add Book
      internal static let button = LocalizedStrings.tr("localizable", "book.add_book.button", fallback: "Add Book")
    }
    internal enum Author {
      /// Author
      internal static let text = LocalizedStrings.tr("localizable", "book.author.text", fallback: "Author")
    }
    internal enum BookCover {
      /// Book Cover
      internal static let text = LocalizedStrings.tr("localizable", "book.book_cover.text", fallback: "Book Cover")
    }
    internal enum BookDetails {
      /// Book Details
      internal static let title = LocalizedStrings.tr("localizable", "book.book_details.title", fallback: "Book Details")
    }
    internal enum Delete {
      /// Delete
      internal static let button = LocalizedStrings.tr("localizable", "book.delete.button", fallback: "Delete")
    }
    internal enum MoveToRecycleBin {
      /// Move to Recycle Bin
      internal static let button = LocalizedStrings.tr("localizable", "book.move_to_recycle_bin.button", fallback: "Move to Recycle Bin")
    }
    internal enum MyLibrary {
      /// My Library
      internal static let title = LocalizedStrings.tr("localizable", "book.my_library.title", fallback: "My Library")
    }
    internal enum Notes {
      /// Notes
      internal static let text = LocalizedStrings.tr("localizable", "book.notes.text", fallback: "Notes")
    }
    internal enum ReadPages {
      /// Read Pages
      internal static let text = LocalizedStrings.tr("localizable", "book.read_pages.text", fallback: "Read Pages")
    }
    internal enum RecycleBin {
      /// Recycle Bin
      internal static let title = LocalizedStrings.tr("localizable", "book.recycle_bin.title", fallback: "Recycle Bin")
    }
    internal enum Restore {
      /// Restore
      internal static let button = LocalizedStrings.tr("localizable", "book.restore.button", fallback: "Restore")
    }
    internal enum RestoreBook {
      /// Restore Book
      internal static let button = LocalizedStrings.tr("localizable", "book.restore_book.button", fallback: "Restore Book")
    }
    internal enum Save {
      /// Save
      internal static let button = LocalizedStrings.tr("localizable", "book.save.button", fallback: "Save")
    }
    internal enum SelectCoverImage {
      /// Select Cover Image
      internal static let button = LocalizedStrings.tr("localizable", "book.select_cover_image.button", fallback: "Select Cover Image")
    }
    internal enum Title {
      /// Title
      internal static let text = LocalizedStrings.tr("localizable", "book.title.text", fallback: "Title")
    }
    internal enum TotalPages {
      /// Total Pages
      internal static let text = LocalizedStrings.tr("localizable", "book.total_pages.text", fallback: "Total Pages")
    }
  }
  internal enum Components {
    internal enum Cancel {
      /// Cancel
      internal static let button = LocalizedStrings.tr("localizable", "components.cancel.button", fallback: "Cancel")
    }
    internal enum Completed {
      /// Completed
      internal static let text = LocalizedStrings.tr("localizable", "components.completed.text", fallback: "Completed")
    }
    internal enum CurrentlyReading {
      /// Currently Reading
      internal static let text = LocalizedStrings.tr("localizable", "components.currently_reading.text", fallback: "Currently Reading")
    }
    internal enum MissingInformation {
      /// Please fill in the Title, Author, and Total Pages fields
      internal static let text = LocalizedStrings.tr("localizable", "components.missing_information.text", fallback: "Please fill in the Title, Author, and Total Pages fields")
      /// Missing Information
      internal static let title = LocalizedStrings.tr("localizable", "components.missing_information.title", fallback: "Missing Information")
    }
    internal enum Ok {
      /// OK
      internal static let button = LocalizedStrings.tr("localizable", "components.ok.button", fallback: "OK")
    }
    internal enum Read {
      /// Read
      internal static let text = LocalizedStrings.tr("localizable", "components.read.text", fallback: "Read")
    }
    internal enum ReadingProgress {
      /// Reading progress
      internal static let text = LocalizedStrings.tr("localizable", "components.reading_progress.text", fallback: "Reading progress")
    }
    internal enum Select {
      /// Select
      internal static let button = LocalizedStrings.tr("localizable", "components.select.button", fallback: "Select")
    }
    internal enum Status {
      /// Localizable.strings
      ///   Readly
      /// 
      ///   Created by tornike <parunashvili on 02.03.25.
      internal static let text = LocalizedStrings.tr("localizable", "components.status.text", fallback: "Status")
    }
    internal enum WantToRead {
      /// Want to Read
      internal static let text = LocalizedStrings.tr("localizable", "components.want_to_read.text", fallback: "Want to Read")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizedStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
