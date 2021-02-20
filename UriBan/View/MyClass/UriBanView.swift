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
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(studentViewModelData.students) { student in
                    NavigationLink(destination: DetailStudentView(student: student)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(growthViewModelData)
                    ) {
                        HStack {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                            Text(student.name).foregroundColor(.black).frame(width: 70, alignment: .leading)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
//                    .padding()
            } // List
//            .background(Color.white)
//            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
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

