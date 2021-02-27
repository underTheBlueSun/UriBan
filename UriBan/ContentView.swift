//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var aaa = ""

    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        


        VStack {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                TextField("상담시간입력", text: $aaa)
                    .font(.system(size: 13))
                    .frame(width: 80)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
            }

        }
//        .background(Color.red)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
