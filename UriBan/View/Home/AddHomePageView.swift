//
//  AddHomePageView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/21.
//

import SwiftUI

struct AddHomePageView: View {
    @EnvironmentObject var modelData: HomeViewModel
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
//                    TextField("학교명을 입력하세요", text: $modelData.school)
//                    TextField("학교명", text: $modelData.school, onEditingChanged: { editing in self.isValidSchool = editing ? false : !modelData.school.isEmpty}, onCommit: { modelData.school = modelData.school.trimmingCharacters(in: .whitespaces) })
                    TextField("학교명", text: $modelData.school, onEditingChanged: { editing in self.isValid = true})
                    
                }
                
                HStack {
                    Image(systemName: "person.2.fill").frame(width: 30)
                    TextField("학반", text: $modelData.className, onEditingChanged: { editing in self.isValid = true})
//                    TextField("학반을 입력하세요", text: $modelData.className)
//                    TextField("학반", text: $modelData.className, onEditingChanged: { editing in self.isValidClass = editing ? false : !modelData.className.isEmpty}, onCommit: { modelData.className = modelData.className.trimmingCharacters(in: .whitespaces) })
                }
                
                Toggle(isOn: $modelData.showMyClass) {
                    Text("우리반")
                }
                .onTapGesture(perform: {
                    self.isValid = true
                })
                
//                HStack {
//                    Spacer()
//                    Text("✳︎ 입력후 엔터키").frame(height: 100).foregroundColor(.gray).opacity(0.5)
//                    Image(systemName: "return").foregroundColor(.gray).opacity(0.5)
//                    Text("를 누르세요").frame(height: 100).foregroundColor(.gray).opacity(0.5)
//                    Spacer()
//                }



            } // List
//            .navigationBarTitle(thisYear + "학년도", displayMode: .inline)
            // 추가인지 수정인지에 따라 타이틀 선택
            .navigationBarTitle(modelData.updateObject == nil ? "반 생성" : "반 수정", displayMode: .inline)
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
//                            // 우리반이 바뀌면 우리반id를 변수에 저장
                            modelData.setUriBanID()
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
