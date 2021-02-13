//
//  MultiSelectRow.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//
import SwiftUI

struct MultiSelectRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                // 고육지책
                Text(self.title).opacity(0.0)
//                Spacer()
                ZStack {
                    Circle()
                        .stroke(self.isSelected ? Color.green : Color.gray,lineWidth: 2)
                        .frame(width: 25, height: 25)
                    
                    if self.isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color.green)
                            .frame(width: 25, height: 25)
                    }
                    
                } // Zstack
            } // Hstack
        }
    }
}
