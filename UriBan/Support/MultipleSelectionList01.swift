//
//  MultipleSelectionList.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/29.
//

import SwiftUI

struct MultipleSelectionList: View {
    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos"]
    @State var selections: [String] = []

    var body: some View {
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

struct MultipleSelectionList_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionList()
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
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
