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
            
//            Text(uuid)
            Text(year)
            Text(school)
            Text(String(myClass))
            
            List {

                ForEach(studentViewModelData.students) { student in


                    Text(student.name)



                } // ForEach


            } // List
            .onAppear() {
                // init()에서 fetchData(uuid:)를 부르면 uuid를 못가져가서 바로 불렀음
                studentViewModelData.fetchData(uuid: self.uuid)
                
                studentViewModelData.uuid = self.uuid
                studentViewModelData.year = self.year
                studentViewModelData.school = self.school
                studentViewModelData.className = self.className
                studentViewModelData.myClass = self.myClass
                
                
            }
            .toolbar { Button(action: {studentViewModelData.openNewPage.toggle()}) { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) } }
            .sheet(isPresented: $studentViewModelData.openNewPage) {
                AddStudentPageView(uuid: uuid, year: year, school: school, className: className, myClass: myClass)
                    .environmentObject(studentViewModelData)
//                AddStudentPageView().environmentObject(studentViewModelData)
            }
        } // Vstack
        
        
        
    
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
