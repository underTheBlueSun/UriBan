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
            List {

                ForEach(studentViewModelData.students) { student in
                    HStack {
                        Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
//                        Text(String(student.number))
                        Text(student.name)
                        
                    }
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
            .fullScreenCover(isPresented: $studentViewModelData.openNewPage) {
//                AddStudentPageView(uuid: uuid, year: year, school: school, className: className, myClass: myClass)
                AddStudentPageView(uuid: uuid, className: className, studentCnt: studentViewModelData.students.count)
                    .environmentObject(studentViewModelData)
//                AddStudentPageView().environmentObject(studentViewModelData)
            }
        } // Vstack
        
   } // body
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(uuid: "", year: "", school: "", className: "", myClass: false)
    }
}
