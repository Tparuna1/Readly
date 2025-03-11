//
//  Grid.swift
//  Readly
//
//  Created by tornike <parunashvili on 09.03.25.
//

import Foundation

/// Defines a grid system for spacing, opacity, cornerRadius, and sizes
public enum Grid {
    public enum Spacing {
        public static let xs3: CGFloat = 4.0
        public static let xs2: CGFloat = 6.0
        public static let xs: CGFloat = 8.0
        public static let s: CGFloat = 12.0
        public static let m: CGFloat = 16.0
        public static let l: CGFloat = 20.0
        public static let xl: CGFloat = 32.0
    }

    public enum Opacity {
        public static let thin: CGFloat = 0.2
    }

    public enum CornerRadius {
        public static let small: CGFloat = 8.0
        public static let medium: CGFloat = 12.0
    }
    
    public enum Size {
        public static let small: CGSize = .init(squareFrame: 100)
        public static let mediumSmall: CGSize = .init(squareFrame: 120)
        public static let semiMedium: CGSize = .init(squareFrame: 150)
        public static let medium: CGSize = .init(squareFrame: 200)
        public static let mediumLarge: CGSize = .init(squareFrame: 300)
    }
}
