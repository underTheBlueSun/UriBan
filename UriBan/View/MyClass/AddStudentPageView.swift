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
    
//    var uuid: String = ""
//    var year: String = ""
//    var school: String = ""
    var className: String = ""
//    var myClass: Bool = false

//    init(uuid: String, year: String, school: String, className: String, myClass: Bool) {
//        self.uuid = uuid
//        self.year = year
//        self.school = school
//        self.className = className
//        self.myClass = myClass
//    }
    
    init(className: String) {
        self.className = className
    }
    
    var body: some View {

        NavigationView {
            List {
                HStack {
                    Image("profile01")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    VStack {
                        HStack {
                            Image(systemName: "number.square.fill").resizable().frame(width: 20, height: 20)
                            TextField("번호", text: $studentViewModelData.name)
                        }
                        HStack {
                            Image(systemName: "number.square.fill").resizable().frame(width: 20, height: 20)
                            TextField("이름을 입력하세요", text: $studentViewModelData.name)
                        }
                        HStack {
                            Image(systemName: "number.square.fill").resizable().frame(width: 20, height: 20)
                            TextField("이름을 입력하세요", text: $studentViewModelData.name)
                        }
                    }
                }
                
            } // List
            .padding(.vertical, 10)
            .navigationBarTitle(className, displayMode: .inline)
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
//            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onDisappear(perform: studentViewModelData.deInitData)
        
        } // NavigationView

        
    }
}

struct AddStudentPageView_Previews: PreviewProvider {
    static var previews: some View {
//        AddStudentPageView(uuid: "", year: "", school: "", className: "", myClass: false)
        AddStudentPageView(className: "5-2반")
            .environmentObject(StudentViewModel())
    }
}
