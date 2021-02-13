//
//  DetailGrowthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI
import PhotosUI

struct DetailGrowthView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @Environment(\.presentationMode) var presentaion
    
    @Namespace var animation
    
    var growth: Growth02
    var uribanClassName: String
        
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    
    init(growth: Growth02, uribanClassName: String) {
         
        self.growth = growth
        // 에러 나서 onAppear 에 적음
//        studentViewModelData.updateObject = self.student
        self.uribanClassName = uribanClassName
//        self.rootIsActive = rootIsActive
    }
    
    var body: some View {
        
        VStack {
            
            TextField("성명", text: $growthViewModelData.content).font(.system(size: 23))

        }
        .padding()
        .navigationBarTitle(uribanClassName, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
//                        studentViewModelData.updateObject = nil
                        presentaion.wrappedValue.dismiss()

                }, label: {
                    Text("")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { growthViewModelData.updData(presentation: presentaion) }, label: {
                    Text("완료")
                })
            } // ToolbarItem
        } // toolbar
        .onAppear(perform: {
//            studentViewModelData.updateObject = self.student
//            images.append(UIImage(data: student.picture as Data) ?? UIImage(imageLiteralResourceName: "profile02"))
//            studentViewModelData.setUpInitialData()
        })
        .onDisappear(perform: {
            // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
            presentaion.wrappedValue.dismiss()
        })

    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
