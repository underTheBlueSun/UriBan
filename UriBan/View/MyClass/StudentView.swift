//
//  StudentView.swift?
//  UriBan
//
//  Created by macbook on 2021/01/27. AAAAJANN
//

import SwiftUI

struct StudentView: View {
    
    var uuid: String
    var year: String
    var school: String
    var className: String
    var myClass: Bool
    
//    @StateObject var studentViewModelData: StudentViewModel
    @StateObject var studentViewModelData: StudentViewModel = StudentViewModel()
    
    // StateObject() 쓰지말고 .onAppear() 이거 쓰란 말도 있음. stackoverflow 참조 : Initialize @StateObject with a parameter in SwiftUI
//    init(uuid: String) {
//        _studentViewModelData = StateObject(wrappedValue: StudentViewModel(uuid: uuid))
//    }
    
    init(uuid: String, year: String, school: String, className: String, myClass: Bool) {
        self.uuid = uuid
        self.year = year
        self.school = school
        self.className = className
        self.myClass = myClass
        
    }
    
    var body: some View {
        VStack {
            
            Text(uuid)
            Text(year)
            Text(school)
            Text(String(myClass))
            
            List {

                ForEach(studentViewModelData.students) { student in


                    Text(student.name)



                } // ForEach


            } // List
            .onAppear() { studentViewModelData.uuid = self.uuid }
            .toolbar { Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) } }
            .sheet(isPresented: $studentViewModelData.openNewPage) {
                AddStudentPageView(uuid: uuid, year: year, school: school, className: className, myClass: myClass).environmentObject(studentViewModelData)
                
            }
        }
        
        
        
    
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
   } // body
}

//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(date: Date())
//    }
//}
