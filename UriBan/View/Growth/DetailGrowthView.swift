//
//  DetailGrowthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI
//import PhotosUI

struct DetailGrowthView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @Namespace var animation
    // 체크리스트 배열
    @State var selections: [String] = []
    
    var growth: Growth02
//    var uribanClassName: String
        
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    
    // .fixed(30) 안하고 .flexible() 하면 세로로 꽉 채움
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 10)
    
    // 텍스트에디터가 키보드에 가리는거 방지
//        @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    init(growth: Growth02) {
         
        self.growth = growth
        // 에러 나서 onAppear 에 적음
//        studentViewModelData.updateObject = self.student
//        self.uribanClassName = uribanClassName
//        self.rootIsActive = rootIsActive
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                VStack {
                    // spacing: 0 은 가로로 벌리는 사이즈
                    LazyHGrid(rows: columns, spacing: 0) {
                        ForEach(studentViewModelData.students, id: \.self) { student in
                            HStack {
                                Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 17, height: 17, alignment: .leading).foregroundColor(.systemTeal)
                                // Text frame width 값을 정해줘야 글자수가 3개가 아니더라도 줄이 맞음
                                Text(student.name).font(.system(size: 16)).frame(width: 45, alignment: .leading)

    //                                let number = String(student.number)
                                //// 1 -> 01 로 집어 넣어야 1번 조회할때 11~19번이 안딸려옴
                                let number = String(format: "%02d", student.number)

                                MultiSelectRow(title: number, isSelected: self.selections.contains(number)) {
                                    if self.selections.contains(number) {
                                        self.selections.removeAll(where: { $0 == number })
                                    }
                                    else {
                                        self.selections.append(number)
                                    }
                                } // MultiSelectRow
                            } // HStack
                        } // ForEach
                        .padding()
                    } // LazyHGrid
                    
                } // Vstack
                .padding()
                Divider()
                VStack(spacing:0) {
                    HStack {
                        Text("관찰기록").foregroundColor(.gray).font(.system(size: 13))
                        Spacer()
                        
                        HStack(spacing: 0) {
                            TabButton(selected: $growthViewModelData.status, title: "좋아요", animation: animation, gubun: 1)
                            TabButton(selected: $growthViewModelData.status, title: "고쳐요", animation: animation, gubun: 2)
                        }
                        .frame(width: 110)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Capsule())
                        
                    }
                    HStack {
                        // AddGrowthlView 와 height가 다른 이유: 300으로 하면 1번 학생 안보임
                        TextEditor(text: $growthViewModelData.content).frame(height:200).fixedSize(horizontal: false, vertical: true)
                            // 텍스트에디터가 키보드에 가리는거 방지
    //                            .background(GeometryGetter(rect: $kGuardian.rects[0]))
    //                        FirstResponderTextEditor(text: $growthViewModelData.content).frame(height:150).fixedSize(horizontal: false, vertical: true)
                    }
                } // VStack
                .padding(.horizontal)
                .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
        //                        studentViewModelData.updateObject = nil
    //                            presentation.wrappedValue.dismiss()

                        }, label: {
                            Text("")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Growth03 만들어서 number를 String으로 바꾼후 growthViewModelData.number 로 고쳐야 함
                            growthViewModelData.name = self.selections.joined(separator: "/")
                            growthViewModelData.updData(presentation: presentation)
                            
                        }, label: {
                            Text("완료")
                        })
                    } // ToolbarItem
                } // toolbar
                .onAppear(perform: {
                    growthViewModelData.updateObject = self.growth
                    growthViewModelData.setUpInitialData()
                    self.selections = self.growth.name.components(separatedBy: "/")
                })
                .onDisappear(perform: {
                    growthViewModelData.deInitData()
                    // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                    presentation.wrappedValue.dismiss()
                })
                
                Spacer()
                
                VStack {
                    Button(action: {growthViewModelData.deleteData(object: growth, presentation: presentation)}, label: { Text("삭제").foregroundColor(.red) })
                }
                .padding()
            } // Vstack
    //            .padding()
            
        }
        
        

            
    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
