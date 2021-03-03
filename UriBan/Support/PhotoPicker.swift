//
//  PhotoPicker.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/05.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {

    @Binding var images: [UIImage]

    let configuration: PHPickerConfiguration
    @Binding var isPresented: Bool
     
    @Environment(\.presentationMode) var presentation
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {

        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            print(results)
            if let image = results.first {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    // retreving the selected image.
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        guard let image1 = image else {
                            return
                        }

                        // appending image.
                        self.parent.images.append(image1 as! UIImage)
                    }

                }
                else {
                    print("cananot be loaded")
                }
            }

//            parent.isPresented = false
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.parent.presentation.wrappedValue.dismiss()
//            }
            parent.presentation.wrappedValue.dismiss()
        }
    }
}
