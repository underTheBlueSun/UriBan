//
//  StudentView.swift?
//  UriBan
//
//  Created by macbook on 2021/01/27.
//

import SwiftUI

struct StudentView: View {
    
    var uuid: String
    @StateObject var studentViewModelData: StudentViewModel
    
    // StateObject() 쓰지말고 .onAppear() 이거 쓰란 말도 있음. stackoverflow 참조 : Initialize @StateObject with a parameter in SwiftUI
    init(uuid: String) {
        _studentViewModelData = StateObject(wrappedValue: StudentViewModel(uuid: uuid))
    }
    
    var body: some View {
        
        List {
            
            ForEach(studentViewModelData.homes) { home in


                Text("aaa")
            
        } // List
        .toolbar { Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) } }
            .sheet(isPresented: $studentViewModelData.openNewPage) { AddStudentPageView().envigsronmentObject(studentViewModelData) }

    } // body
    
//    var body: some View {
//
//        VStack {
//
//            ScrollView {
//    //                ForEach(studentViewModelData.students) { student in
//    //                    Text(student.school)
//    //
//    //                } // ForEach
//
//            }
//
//        } // VStack
////        .edgesIgnoringSafeArea(.top)
//        .toolbar {
////            Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white)
//            Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
//        }
////            .onAppear(perform: {
////                print("onappear")
////            })
//
//
//
//
//
//    }
}

//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(date: Date())
//    }
//}
