//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    let filepath = "file:///Users/macbook/Library/Developer/CoreSimulator/Devices/DE1B5FA8-02DD-4AE9-AD4D-2C1A702CC3EA/data/Containers/Data/Application/66637678-3224-4FA2-8F09-3AD7B2095D79/Documents/4D854D05-D5CC-41B2-9EBF-798415AE4B40-5.png"
    var picture = UIImage()
    
    func loadImage(at path: String) -> UIImage? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0]
        let imagePath = documentPath.appending(path)
        guard fileExists(at: imagePath) else {
            return nil
        }
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return nil
        }
        return image
    }
    
    func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    var body: some View {
        VStack {
            
            Text("aaaa")
            Image(uiImage: loadImage(at: filepath)!)

            
            Text("bbbb")
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
