//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/28.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var downloadAmount = 11.1
    
    var body: some View {
        Text("Hello World")
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .background(Color.red)
            .ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
