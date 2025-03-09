//
//  Extension.CGSize.swift
//  Readly
//
//  Created by tornike <parunashvili on 09.03.25.
//

import SwiftUI

public extension CGSize {
    /// Custom initializer for square frames
    init(squareFrame side: CGFloat) {
        self.init(width: side, height: side)
    }
}
