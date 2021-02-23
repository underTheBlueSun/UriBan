//
//  SwiftUIView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/21.
//

import SwiftUI

enum ActiveSheetExam: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct SwiftUIView: View {
    @State var activeSheet: ActiveSheetExam?

    var body: some View {
        VStack {
            Button(action: {
                activeSheet = .first
            }) {
                Text("Activate first sheet")
            }

            Button(action: {
                activeSheet = .second
            }) {
                Text("Activate second sheet")
            }
        }
        .fullScreenCover(item: $activeSheet) { item in
            switch item {
            case .first:
                SwiftUIView2()
            case .second:
                SwiftUIView3()
            }
        }
    }
}
