//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
       
//        NavigationView {
            Text("aaaaa").frame(width: 250, height: 20, alignment: .leading).font(.system(size: 15))
             
//        }
        
       
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
