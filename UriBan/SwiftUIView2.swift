//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        VStack {
            let aaa: Double = 1/(2*24)
            Text(String(aaa * 100))
            Text(String(11.111))
        }
        
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView2()
    }
}
