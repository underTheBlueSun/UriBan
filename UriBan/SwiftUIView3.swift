//
//  SwiftUIView3.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/23.
//

import SwiftUI

struct SwiftUIView3: View {
    var body: some View {
        ZStack {
            Rectangle()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.white).frame(height: 100, alignment: .top)
        }
    }
}

struct SwiftUIView3_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView3()
    }
}
