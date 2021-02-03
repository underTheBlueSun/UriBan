//
//  PHPickerExam.swift
//  UriBan
//
//  Created by macbook on 2021/02/03.
//

import SwiftUI
import PhotosUI

struct PHPickerMultiExam: View {
    
    @State var images: [UIImage] = []
    @State var picker = false
    
    var body: some View {
        
        VStack {
            if !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15) {
                        ForEach(images, id: \.self) { img in
                            Image(uiImage: img)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 45, height: 100)
                                .cornerRadius(20)
                        } // ForEach
                    } // Hstack
                }) // ScrollView
                    
                
            } // if
            else {
                Button(action: {
                    picker.toggle()
                }, label: {
                    Text("Pick Images")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
            } // ese
        } // Vstack
        // calling picker.
        .sheet(isPresented: $picker) {
            ImagePicker(images: $images, picker: $picker)
        }
    }
}

struct PHPickerExam_Previews: PreviewProvider {
    static var previews: some View {
        PHPickerMultiExam()
    }
}

// New Image Picker API

struct ImagePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coodinator {
        return ImagePicker.Coodinator(parent1: self)
    }
    
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        // you can also select videos using this picker.
        config.filter = .images
        // 0 is used for multiple selection.
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        // adding delegate.
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coodinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker

//        override init(parent1: ImagePicker) {
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // closing picker.
            parent.picker.toggle()
            
            for img in results { 
            
                // checking whether the image can be load.
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    // retreving the selected image.
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        guard let image1 = image else {
                            print(err)
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
        }
        
        
    }
    

   
    
}

