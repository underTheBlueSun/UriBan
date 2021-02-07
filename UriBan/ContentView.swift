//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    var pictureData: Data
    
    var body: some View {
        
        VStack {
            Text("aaaaaaa")
            
            let pictureImg = UIImage(data: pictureData)
            
            Image(uiImage: (pictureImg ?? UIImage(imageLiteralResourceName: "profile02")))
            
//            guard let aaa =  pictureImg else {return}
            
//            Image(uiImage: UIImage(data: pictureData))
            
            
            
        }
        
        
    }
}



