//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var gubun: Int = 1
    
    var body: some View {
        
        ZStack {
            // Capsule and Sliding Effect.
            Capsule()
                .fill(Color.clear)
                .frame(height: 22)
            
//            if selected == title {
                
                if gubun == 1 {
                    Capsule()
                        .fill(Color.systemTeal)
                        .frame(height: 22)
//                        .matchedGeometryEffect(id: "Tab", in: animation)
                    
                } else {
                    Capsule()
                        .fill(Color.tabButtonRed)
                        .frame(height: 22)
//                        .matchedGeometryEffect(id: "Tab", in: animation)
                    
                }
                
                
                
//            }
            
            Text("aaa")
//                .foregroundColor(selected == title ? .white : .white)
                .font(.system(size: 14))
//                    .fontWeight(.bold)
        } // Zstack
       
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
