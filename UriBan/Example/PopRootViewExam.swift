//
//  PopRootViewExam.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/12.
//

import SwiftUI

struct PopRootViewExam: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: PopRootViewExamDetail(rootIsActive: self.$isActive), isActive: self.$isActive) {
                Text("Hello, World!")
            }
//            .isDetailLink(false)
            .navigationBarTitle("Root")
        }
    }
}

struct PopRootViewExamDetail: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        VStack {
            Button (action: { self.rootIsActive = false } ){
                Text("루트로 가즈아....")
            }
        }.navigationBarTitle("둘")
    }
}



struct PopRootViewExam_Previews: PreviewProvider {
    static var previews: some View {
        PopRootViewExam()
    }
}
