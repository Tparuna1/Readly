//
//  Extension.UIImage.swift
//  Readly
//
//  Created by tornike <parunashvili on 09.03.25.
//

import UIKit

extension UIImage {
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
