//
//  ContentView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/19.
//

import SwiftUI

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

struct ContentView : View {
    @State private var name: String = ""

    var body: some View {
        Background {
            VStack {
                Text("Hello \(self.name)")
                TextField("Name...", text: self.$name) {
                    self.endEditing()
                }
            }
        }.onTapGesture {
            self.endEditing()
        }
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
