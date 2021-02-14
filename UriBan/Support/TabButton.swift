//
//  TabButton.swift
//  UriBan
//
//  Created by macbook on 2021/02/04.
//

import SwiftUI

struct TabButton: View {
    
    @Binding var selected: String
    var title: String
    var animation: Namespace.ID
    var gubun: Int
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()) {
                selected = title
                
            }
        }) {
            ZStack {
                // Capsule and Sliding Effect.
                Capsule()
                    .fill(Color.clear)
                    .frame(height: 22)
                
                if selected == title {
                    
                    if gubun == 1 {
                        Capsule()
                            .fill(Color.systemTeal)
                            .frame(height: 22)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                        
                    } else {
                        Capsule()
                            .fill(Color.tabButtonRed)
                            .frame(height: 22)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                        
                    }
                    
                    
                    
                }
                
                Text(title)
                    .foregroundColor(selected == title ? .white : .white)
                    .font(.system(size: 14))
//                    .fontWeight(.bold)
            } // Zstack
        } // Button
        
    }
}
