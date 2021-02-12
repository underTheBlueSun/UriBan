//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI


import SwiftUI

struct TestPopToRootInTab: View {
    @State private var myState = "original"

    init(_ yourState:String) {
//        self.myState = yourState
        
    }

    var body: some View {
        Text(myState)
            .onAppear {
            self.myState = "appear"
        }
    }
}

struct TestPopToRootInTab_Previews: PreviewProvider {
    static var previews: some View {
        TestPopToRootInTab("aaaa")
    }
}



