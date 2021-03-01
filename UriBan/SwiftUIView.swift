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
        VStack {
                    ProgressView("Downloading…", value: downloadAmount, total: 100)
                }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
