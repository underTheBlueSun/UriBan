//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/14.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var text = ""
    
//    let aaa = "1/2/3"
    
    
  
    
    var body: some View {
        
        let fullName = "First"
        
        var fullNameArr = fullName.split{$0 == "/"}.map(String.init)
        var aaa = fullName.components(separatedBy: "/")
        
        VStack {
            Button(action: {
                print(fullNameArr)
                print(aaa)
            }, label: {
                Text("Button")
            })
                
        }
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
