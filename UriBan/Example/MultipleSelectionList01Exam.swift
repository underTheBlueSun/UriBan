//
//  MultipleSelectionList.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/29.
//

import SwiftUI

struct MultipleSelectionList01: View {
    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos"]
    @State var selections: [String] = []

    var body: some View {

        
        VStack {
            Button(action: { print(self.selections.joined(separator: "/")) }, label: {
                Text("Button")
            })
            
            List {
                ForEach(self.items, id: \.self) { item in
                    MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                        if self.selections.contains(item) {
                            self.selections.removeAll(where: { $0 == item })
                        }
                        else {
                            self.selections.append(item)
                        }
                    }
                }
            }
        }
    }
}

struct MultipleSelectionList01_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionList01()
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                Spacer()
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
