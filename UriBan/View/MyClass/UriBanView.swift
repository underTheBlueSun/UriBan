//
//  UriBanView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/11.
//

import SwiftUI

struct UriBanView: View {
    
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(studentViewModelData.students) { student in
                    NavigationLink(destination: DetailStudentView(student: student)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(growthViewModelData)
                                    .environmentObject(subjectViewModelData)
                    ) {
                        HStack {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                            Text(student.name).foregroundColor(.black).frame(width: 70, alignment: .leading)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        studentViewModelData.openNewPage.toggle()
                    }, label: {
                        if homeViewModelData.uribanID != "" { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
                    })
                } // ToolbarItem
            } // toolbar
            
        } // NavigationView
        .fullScreenCover(isPresented: $studentViewModelData.openNewPage) {
            AddStudentView(studentCnt: studentViewModelData.students.count)
                .environmentObject(studentViewModelData)
                .environmentObject(homeViewModelData)
//            AddStudentView(studentCnt: studentViewModelData.students.count, uribanClassName: homeViewModelData.uribanClassName)
//                .environmentObject(studentViewModelData)
        } // fullScreenCover
        .onAppear() {
            // 홈에서 삭제를 누르면 이상하게 여기 onAppear()가 불려짐. ㅠㅠ 그래서 setUriBanID() 가져옴.
            homeViewModelData.setUriBanID()
            
            if homeViewModelData.uribanID == "" {
                studentViewModelData.fetchData(uuid: "")
            }else {
                studentViewModelData.fetchData(uuid: homeViewModelData.uribanID)
            }
        } // onAppear
        .navigationViewStyle(StackNavigationViewStyle())
   } // body
}

//struct UriBanView_Previews: PreviewProvider {
//    static var previews: some View {
//        UriBanView().environmentObject(HomeViewModel())
//    }
//}

