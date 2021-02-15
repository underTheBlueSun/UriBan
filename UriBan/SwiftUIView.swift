//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/14.
//

import SwiftUI

struct SwiftUIView: View {
    
    
    
    var body: some View {
        
//        var array = ["1", "2"]
//        var arrayZero = String(format: "%02d", array)
        
        let string = "/1/"
        let array = string.components(separatedBy: "/")
//        str.components(separatedBy: ["~","!","@",","]).joined()

        
        VStack {
            Button(action: {
                print(String(format: "%02d", 1))
            }, label: {
//                Text(array.joined(separator:"/") + "/")
                Text(String(format: "%02d", 2))
            })
            
        }
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
