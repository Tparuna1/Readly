//
//  Extension.UIImage.swift
//  Readly
//
//  Created by tornike <parunashvili on 09.03.25.
//

import UIKit

/// Extension for `UIImage` to add image processing utilities.
extension UIImage {
    
    /// Resizes the image while maintaining its aspect ratio.
    ///
    /// - Parameter targetHeight: The desired height of the resized image.
    /// - Returns: A new `UIImage` instance with the specified height, or `nil` if resizing fails.
    func resize(targetHeight: CGFloat) -> UIImage? {
        let aspectRatio = self.size.width / self.size.height
        let targetWidth = targetHeight * aspectRatio
        let size = CGSize(width: targetWidth, height: targetHeight)

        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}
