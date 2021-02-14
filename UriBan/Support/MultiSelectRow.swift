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
            HStack(spacing: 0) {
//                Text(self.title)
//                Spacer()
                ZStack {
                    Circle()
                        .stroke(self.isSelected ? Color.green : Color.gray,lineWidth: 2)
                        .frame(width: 17, height: 17)
                    if self.isSelected {
                        Image(systemName: "checkmark.circle.fill")
//                            .font(.system(size: 20))
                            .foregroundColor(Color.green)
                            .frame(width: 17, height: 17)
                    }
                } // Zstack
            } // Hstack
        } // Button
    }
}
