//
//  ContentView.swift
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI


import SwiftUI

struct TestPopToRootInTab: View {
    @State private var selection = 0
    @State private var resetNavigationID = UUID()

    var body: some View {

        let selectable = Binding(        // << proxy binding to catch tab tap
            get: { self.selection },
            set: { self.selection = $0

                // set new ID to recreate NavigationView, so put it
                // in root state, same as is on change tab and back
                self.resetNavigationID = UUID()
        })

        return TabView(selection: selectable) {
            self.tab1()
                .tabItem {
                    Image(systemName: "1.circle")
                }.tag(0)
            self.tab2()
                .tabItem {
                    Image(systemName: "2.circle")
                }.tag(1)
        }
    }

    private func tab1() -> some View {
        NavigationView {
            NavigationLink(destination: TabChildView()) {
                Text("Tab1 - Initial")
            }
        }.id(self.resetNavigationID) // << making id modifiable
    }

    private func tab2() -> some View {
        Text("Tab2")
    }
}

struct TabChildView: View {
    var number = 1
    var body: some View {
        NavigationLink("Child \(number)",
            destination: TabChildView(number: number + 1))
    }
}

struct TestPopToRootInTab_Previews: PreviewProvider {
    static var previews: some View {
        TestPopToRootInTab()
    }
}



