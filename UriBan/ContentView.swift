//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
       
        NavigationView {
            Text("사랑하는 은희, 예림, 민욱을 위해...")
                .navigationBarTitle("^^", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("취소")
                        })
                    }
                } // toolbar
             
        }
        
       
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
