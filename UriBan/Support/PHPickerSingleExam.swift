//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import PhotosUI

struct PHPickerSingleExam: View {
    
    @State var images: [UIImage] = []
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            if !images.isEmpty {
                Image(uiImage: images[0])
                    .resizable()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            else {
                Button("Present Picker") {
                    isPresented.toggle()
                }
            }
            
        }
        .sheet(isPresented: $isPresented) {
                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                    PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
        }
        

        
    }
}
struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]
    
    let configuration: PHPickerConfiguration
    @Binding var isPresented: Bool
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
                            print("에러:", err)
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
            
            
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
    }
}

struct PHPickerSingleExam_Previews: PreviewProvider {
    static var previews: some View {
        PHPickerSingleExam()
    }
}
