//
//  StudentView.swift?
//  UriBan
//
//  Created by macbook on 2021/01/27. AAAAJANN
//

import SwiftUI

struct StudentView: View {
    
    var uribanID: String
    var uribanClassName: String
//
//    @StateObject var studentViewModelData: StudentViewModel = StudentViewModel()
//
//    init(uribanID: String, uribanClassName: String) {
//        self.uribanID = uribanID
//        self.uribanClassName = uribanClassName
//    }
    
    var body: some View {
        VStack {
//            List {
//                ForEach(studentViewModelData.students) { student in
//                    NavigationLink(destination: DetailStudentView(student: student, uribanClassName: uribanClassName).environmentObject(studentViewModelData)) {
////                    NavigationLink(destination: ContentView(pictureData: student.picture as Data)) {
//                        HStack {
//                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
//                            Text(student.name)
//                        } // Hstack
//                    } // NavigationView
//                } // ForEach
//            } // List
//            .onAppear() {
//                studentViewModelData.fetchData(uuid: uribanID)
//            }
//            .toolbar { Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) } }
//            .fullScreenCover(isPresented: $studentViewModelData.openNewPage) {
////                AddStudentView(uuid: uuid, className: className, studentCnt: studentViewModelData.students.count)
//                AddStudentView(studentCnt: studentViewModelData.students.count, uribanClassName: uribanClassName)
//                    .environmentObject(studentViewModelData)
//            }
        } // Vstack
        
   } // body
}

//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(uribanID: "", uribanClassName: "")
//    }
//}
