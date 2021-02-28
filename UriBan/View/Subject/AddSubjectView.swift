//
//  AddSubjectView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI

struct AddSubjectView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @State var selections: [String] = []
    
    @Namespace var animation
    
    // 텍스트에디터가 키보드에 가리는거 방지
//    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
        
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 10)
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    LazyHGrid(rows: columns, spacing: 0) {
                        ForEach(studentViewModelData.students, id: \.self) { student in
                            HStack {
                                Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 17, height: 17, alignment: .leading).foregroundColor(.systemTeal)
                                // Text frame width 값을 정해줘야 글자수가 3개가 아니더라도 줄이 맞음
                                Text(student.name).font(.system(size: 16)).frame(width: 45, alignment: .leading)

//                                let number = String(student.number)
                                // 1 -> 01 로 집어 넣어야 01번 조회할때 11~19번이 안딸려옴
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
                        Text("과제기록").foregroundColor(.gray).font(.system(size: 13))
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $subjectViewModelData.content).frame(height:300).fixedSize(horizontal: false, vertical: true)
                            // 텍스트에디터가 키보드에 가리는거 방지
//                            .background(GeometryGetter(rect: $kGuardian.rects[0]))

//                        FirstResponderTextEditor(text: $subjectViewModelData.content).frame(height:100).fixedSize(horizontal: false, vertical: true)
                    }
                } // VStack
                .padding(.horizontal)
                .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                                presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("취소")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // + "/" 을 붙힌 이유: 1을 조회하는데 11 ~19 애들이 나오면 안되니깐
//                                growthViewModelData.name = "/" + self.selections.joined(separator: "/") + "/"
                            subjectViewModelData.number = self.selections.joined(separator: "/")
                            subjectViewModelData.count = self.selections.count
                            subjectViewModelData.addData(uuid: homeViewModelData.uribanID , presentation: presentation)
                            
                        }, label: {
                            if self.selections.count != 0 && subjectViewModelData.content != "" {
                                Text("완료")
                            }
                            
                        })
                    } // ToolbarItem
                } // toolbar
                .onAppear(perform: {
        //            studentViewModelData.updateObject = self.student
        //            studentViewModelData.setUpInitialData()
                })
                .onDisappear(perform: {
                    subjectViewModelData.deInitData()
                    // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                    presentation.wrappedValue.dismiss()
                })
                
//                Divider()
                Spacer()
            } // Vstack
//            .padding()
            
        } // NavigationView
        
        

    }
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
            .environmentObject(StudentViewModel())
            .environmentObject(SubjectViewModel())
            .environmentObject(HomeViewModel())
    }
}
