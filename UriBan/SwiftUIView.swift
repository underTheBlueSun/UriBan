//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        HStack {
            Text("aaaa")
            Text("bbbbb")
            
        }
        .background(Color.systemGray.opacity(0.2))
        .font(.system(size: 20))

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
