//
//  ImagePickerService.swift
//  Readly
//
//  Created by tornike <parunashvili on 01.03.25.
//

import SwiftUI
import PhotosUI

/// A SwiftUI wrapper for `UIImagePickerController` to allow users to select an image from the photo library.
struct ImagePicker: UIViewControllerRepresentable {
    
    /// The selected image, bound to the parent view.
    @Binding var selectedImage: UIImage?

    /// A coordinator class that acts as a delegate for `UIImagePickerController`.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        /// A reference to the parent `ImagePicker` instance.
        let parent: ImagePicker

        /// Initializes the coordinator with a reference to the parent `ImagePicker`.
        ///
        /// - Parameter parent: The `ImagePicker` instance that owns this coordinator.
        init(parent: ImagePicker) {
            self.parent = parent
        }

        /// Handles the image selection event when the user picks an image.
        ///
        /// - Parameters:
        ///   - picker: The `UIImagePickerController` instance.
        ///   - info: A dictionary containing information about the selected media.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }

    /// Creates the coordinator that handles interactions with `UIImagePickerController`.
    ///
    /// - Returns: An instance of `Coordinator`.
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    /// Creates and configures a `UIImagePickerController` instance.
    ///
    /// - Parameter context: The SwiftUI context containing the coordinator.
    /// - Returns: A configured `UIImagePickerController` instance.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }

    /// Updates the `UIImagePickerController` instance when the SwiftUI state changes.
    ///
    /// - Parameters:
    ///   - uiViewController: The `UIImagePickerController` instance.
    ///   - context: The SwiftUI context containing the coordinator.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
