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
                    .frame(height: 20)
                
                if selected == title {
                    Capsule()
                        .fill(Color.systemTeal)
                        .frame(height: 20)
                    // Mathced Geometry Effect.
                        .matchedGeometryEffect(id: "Tab", in: animation)
                    
                }
                
                Text(title)
                    .foregroundColor(selected == title ? .black : .white)
                    .font(.system(size: 12))
//                    .fontWeight(.bold)
            } // Zstack
        } // Button
        
    }
}
