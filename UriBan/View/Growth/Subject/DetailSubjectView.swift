//
//  DetailSubjectView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/20.
//

import SwiftUI

struct DetailSubjectView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @Namespace var animation
    // 체크리스트 배열
    @State var selections: [String] = []
    
    var subject: Subject02
        
    // 성명을 입력해야 완료 버튼이 활성화 되게
//    @State private var isValidName = false
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 10)    
    
    init(subject: Subject02) {
        self.subject = subject
    }
    
    var body: some View {
        
        VStack {
            VStack {
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
                    Text("과제기록").foregroundColor(.gray)
                    Spacer()
                }
                HStack {
                    TextEditor(text: $subjectViewModelData.content).frame(height:110).fixedSize(horizontal: false, vertical: true)
                }
            } // VStack
            .padding(.horizontal)
            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            presentation.wrappedValue.dismiss()

                    }, label: {
                        Text("")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        subjectViewModelData.number = self.selections.joined(separator: "/")
                        subjectViewModelData.count = self.selections.count
                        subjectViewModelData.updData(presentation: presentation)
                    }, label: {
                        Text("완료")
                    })
                } // ToolbarItem
            } // toolbar
            .onAppear(perform: {
                subjectViewModelData.updateObject = self.subject
                subjectViewModelData.setUpInitialData()
                self.selections = self.subject.number.components(separatedBy: "/")
            })
            .onDisappear(perform: {
                subjectViewModelData.deInitData()
                // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                presentation.wrappedValue.dismiss()
            })
            
            Spacer()
            
            VStack {
                Button(action: {subjectViewModelData.deleteData(object: subject, presentation: presentation)}, label: { Text("삭제").foregroundColor(.red) })
            }
            .padding()
        } // Vstack
//            .padding()

            
    }
}

//struct DetailSubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailSubjectView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
