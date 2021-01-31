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
    
//    @State private var showMyClass = true
    
    // 오늘 날짜 가져오기
//    private func getDate(format: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        let date = Date()
//        let today = dateFormatter.string(from: date)
//        return today
//    }
//
//    var thisYear: String = ""
//
//    init() {
//        thisYear = self.getDate(format: "yyyy")
//    }
    
    
    
    var body: some View {
        NavigationView {
            
            List {
                
                HStack {
                    Image(systemName: "building.columns.fill").frame(width: 30)
                    TextField("학교명을 입력하세요", text: $studentViewModelData.school)
                    
                }
                
                HStack {
                    Image(systemName: "person.2.fill").frame(width: 30)
                    TextField("학반을 입력하세요", text: $studentViewModelData.className)
                }
                
                Toggle(isOn: $studentViewModelData.showMyClass) {
                    Text("우리반")
                }

            }
//            .navigationBarTitle(thisYear + "학년도", displayMode: .inline)
            // 추가인지 수정인지에 따라 타이틀 선택
            .navigationBarTitle(studentViewModelData.updateObject == nil ? "Add Data" : "Update", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
//                  스윗한 스위프트 p303 참고 (조금 다름)
                    Button(action: {
                            studentViewModelData.updateObject = nil
                            presentaion.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("취소")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {studentViewModelData.addData(thisYear: thisYear, presentation: presentaion)}, label: {
                        Text("완료")
                    })
                }
            }
        } // NavigationView
        .onAppear(perform: studentViewModelData.setUpInitialData)
        .onDisappear(perform: studentViewModelData.deInitData)
        
//        이게 원래 정석인데
//        .onDisappear(perform: { studentViewModelData.deInitData() })
        
    }
}

struct AddStudentPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentPageView()
            .environmentObject(StudentViewModel())
    }
}
