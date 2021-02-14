//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/14.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var text = ""
    var body: some View {
        
        VStack {
            FirstResponderTextEditor(text: $text)
                .frame(height: 100)
                .padding()
                .background(Color.red)
                
        }
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
