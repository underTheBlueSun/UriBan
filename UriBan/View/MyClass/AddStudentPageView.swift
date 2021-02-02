//
//  AddStudentPageView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/31.
//

import SwiftUI

struct AddStudentPageView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
//    스윗한 스위프트 p303 참고
    @Environment(\.presentationMode) var presentaion
    
    var uuid: String = ""
    var year: String = ""
    var school: String = ""
    var className: String = ""
    var myClass: Bool = false

    init(uuid: String, year: String, school: String, className: String, myClass: Bool) {
        self.uuid = uuid
        self.year = year
        self.school = school
        self.className = className
        self.myClass = myClass
    }
    
    
    
    var body: some View {

        NavigationView {
            List {
//                Text(uuid)
//                Text(year)
//                Text(String(myClass))
                Image(systemName: "building.columns.fill").frame(width: 30)
                TextField("이름을 입력하세요", text: $studentViewModelData.name)


                
            } // List
            .navigationBarTitle("우리반", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            studentViewModelData.updateObject = nil
                            presentaion.wrappedValue.dismiss()

                    }, label: {
                        Text("취소")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {studentViewModelData.addData(presentation: presentaion)}, label: {
                        Text("완료")
                    })
                }
            } // toolbar
            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onDisappear(perform: studentViewModelData.deInitData)
        
        } // NavigationView

        
    }
}

struct AddStudentPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentPageView(uuid: "", year: "", school: "", className: "", myClass: false)
            .environmentObject(StudentViewModel())
    }
}
