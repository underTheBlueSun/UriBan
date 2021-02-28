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
        
        NavigationView {
            Text("bbbbb")
//            ScrollView {
//                List{
//                    Text("aaaa")
//                    NavigationLink(destination: SwiftUIView()) {
//                    } // NavigationLink
//
//                }
//            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
       
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
