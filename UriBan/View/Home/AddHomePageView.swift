//
//  AddHomePageView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/21.
//

import SwiftUI

struct AddHomePageView: View {
    @EnvironmentObject var modelData: HomeViewModel
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    
//    스윗한 스위프트 p303 참고
    @Environment(\.presentationMode) var presentaion
    
    // 학교명과 학반을 입력해야 완료 버튼이 활성화 되게
//    @State private var isValidSchool = false
//    @State private var isValidClass = false
    
    // 학교명 또는 학반 또는 우리반 체크하면 완료버튼 생셩
    @State private var isValid = false
    
    // 오늘 날짜 가져오기
    private func getDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = Date()
        let today = dateFormatter.string(from: date)
        return today
    }
    
    var thisYear: String = ""
    
    init() {
        thisYear = self.getDate(format: "yyyy")
    }
    
    
    
    var body: some View {
        NavigationView {
            List {
                
                HStack {
                    Image(systemName: "building.columns.fill").frame(width: 30)
                    // 반 추가이면
                    if modelData.updateObject == nil {
                        // 학교명에 포커싱 주기 but 에러 : 수정 누르면 학교명이 사라져 있음 ㅠㅠ
                        FirstResponderTextField(text: $modelData.school, placeholder: " 학교명").frame(height: 30)
                    } else {
                        TextField("학교명", text: $modelData.school, onEditingChanged: { editing in self.isValid = true})
                    }
                    
                }
                HStack {
                    Image(systemName: "person.2.fill").frame(width: 30)
                    TextField(" 학반", text: $modelData.className, onEditingChanged: { editing in self.isValid = true})
//                    TextField("학반을 입력하세요", text: $modelData.className)
//                    TextField("학반", text: $modelData.className, onEditingChanged: { editing in self.isValidClass = editing ? false : !modelData.className.isEmpty}, onCommit: { modelData.className = modelData.className.trimmingCharacters(in: .whitespaces) })
                }
                
                Toggle(isOn: $modelData.showMyClass) {
                    Text("우리반")
                }
                .onTapGesture(perform: {
                    self.isValid = true
                })
            } // List
//            .navigationBarTitle(thisYear + "학년도", displayMode: .inline)
            // 추가인지 수정인지에 따라 타이틀 선택
            .navigationBarTitle(modelData.updateObject == nil ? "우리반 만들기" : "우리반 수정", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
//                  스윗한 스위프트 p303 참고 (조금 다름)
                    Button(action: {
                            modelData.updateObject = nil
                            presentaion.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("취소")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
//                    if isValidSchool && isValidClass {
                    if isValid {
                        Button(action: {
                            modelData.year = thisYear
                            modelData.addData(presentation: presentaion)
//                          // 우리반이 바뀌면 우리반id를 변수에 저장
                            modelData.setUriBanID()
//                          // onAppear가 이상작동하여 여기서 미리 우리반학생배열, 관찰배열등을 만듬
                            studentViewModelData.fetchData(uuid: modelData.uribanID)
                            growthViewModelData.fetchData(uuid: modelData.uribanID)
                            subjectViewModelData.fetchData(uuid: modelData.uribanID)
                        }, label: {
                            Text("완료")
                        })
                    } // if

                } // ToolbarItem
            }
            
        } // NavigationView
        .onAppear(perform: modelData.setUpInitialData)
        .onDisappear(perform: modelData.deInitData)
        
//        이게 원래 정석인데
//        .onDisappear(perform: { modelData.deInitData() })
        
    }
}

struct AddHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomePageView()
            .environmentObject(HomeViewModel())
    }
}
