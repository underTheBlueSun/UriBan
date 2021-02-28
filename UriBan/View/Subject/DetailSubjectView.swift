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
        
    // 텍스트에디터가 키보드에 가리는거 방지
//    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 10)
    
    init(subject: Subject02) {
        self.subject = subject
    }
    
    var body: some View {
        
        ScrollView {
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
                        Text("과제기록").foregroundColor(.gray).font(.system(size: 13))
                        Spacer()
                    }
                    HStack {
                        // AddSubjectlView 와 height가 다른 이유: 300으로 하면 1번 학생 안보임
                        TextEditor(text: $subjectViewModelData.content).frame(height:200).fixedSize(horizontal: false, vertical: true)
                            // 텍스트에디터가 키보드에 가리는거 방지
    //                        .background(GeometryGetter(rect: $kGuardian.rects[0]))
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
                            if self.selections.count != 0 && subjectViewModelData.content != "" {
                                Text("완료")
                            }
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
                    // .navigationViewStyle(StackNavigationViewStyle()) 이거때문. 아이패드와 같은 화면되게하려면 어쩔수없음 ㅠㅠ
//                    presentation.wrappedValue.dismiss()
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
}

//struct DetailSubjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailSubjectView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
