//
//  UriBanView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/11.
//



import SwiftUI

struct UriBanView: View {
    
//    var uribanID: String
//    var uribanClassName: String

//    @StateObject var studentViewModelData: StudentViewModel = StudentViewModel()
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
    // StateObject() 쓰지말고 .onAppear() 이거 쓰란 말도 있음. stackoverflow 참조 : Initialize @StateObject with a parameter in SwiftUI
//    init(uuid: String) {
//        _studentViewModelData = StateObject(wrappedValue: StudentViewModel(uuid: uuid))
//    }
    
//    init(uribanID: String, uribanClassName: String) {
//        self.uribanID = uribanID
//        self.uribanClassName = uribanClassName
//    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(studentViewModelData.students) { student in
                    NavigationLink(destination: DetailStudentView(student: student)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(homeViewModelData)
                    ) {
//                    NavigationLink(destination: DetailStudentView(student: student, uribanClassName: homeViewModelData.uribanClassName).environmentObject(studentViewModelData)) {
                        HStack {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                            Text(student.name)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .background(Color.white)
            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
//            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar { Button(action: {studentViewModelData.openNewPage.toggle()}) {
                if homeViewModelData.uribanID != "" {
                    Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white)
                }
                
                
            }
            }
        } // NavigationView
        .fullScreenCover(isPresented: $studentViewModelData.openNewPage) {
            AddStudentView(studentCnt: studentViewModelData.students.count)
                .environmentObject(studentViewModelData)
                .environmentObject(homeViewModelData)
//            AddStudentView(studentCnt: studentViewModelData.students.count, uribanClassName: homeViewModelData.uribanClassName)
//                .environmentObject(studentViewModelData)
        }
        .onAppear() {
            // init()에서 fetchData(uuid:)를 부르면 uuid를 못가져가서 바로 불렀음
            studentViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }
   } // body
}

//struct UriBanView_Previews: PreviewProvider {
//    static var previews: some View {
//        UriBanView().environmentObject(HomeViewModel())
//    }
//}

