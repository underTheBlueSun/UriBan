//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI

class SampleObject: ObservableObject {
    @Published var id: Int = 0
}

struct ContentView: View {
    @StateObject private var sampleObject = SampleObject()
    
    var body: some View {
        List {
            Text("Identifier: \(sampleObject.id)")

            
        }
        .onAppear() {
            sampleObject.id = 4000
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
