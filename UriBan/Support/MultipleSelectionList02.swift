//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/29.
//

import SwiftUI




struct SwiftUIView: View {
    
    @State var recordArray: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos"]
    @State var selectedItems: Array = []
    @State var selections: String?

    
    var body: some View {
        List() {
            ForEach(self.recordArray, id: \.self) { record in
                Text(record)
                .onTapGesture {
                   if self.selectedItems.first(where: { $0 as! String == record } ) != nil {
                        self.selectedItems.removeAll(where: { $0 as! String == record } )
                    } else {
                        self.selectedItems.append(record)
                        print(selectedItems)
                    }
                    
                }
                .foregroundColor((self.selectedItems.first(where: { $0 as! String == record } ) != nil) ? Color(.red) : Color(.black))
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
