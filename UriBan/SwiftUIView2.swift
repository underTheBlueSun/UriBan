//
//  SwiftUIView2.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/22.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        NavigationView {
            List {
//                Text("aaaa")
            }
            
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
//                        studentViewModelData.openNewPage.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white)
                    })
                } // ToolbarItem
            } // toolbar
            
            Text("bbbbb")
            Spacer()
        }
        
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView2()
    }
}
