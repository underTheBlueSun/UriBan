//
//  DetailCounselView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI

struct DetailCounselView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    @EnvironmentObject var counselViewModelData: CounselViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @Namespace var animation
    // 체크리스트 배열
    @State var selections: [String] = []
    
    // 텍스트에디터가 키보드에 가리는거 방지
//    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)

    
    var counsel: Counsel02
        
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 10)
    
    init(counsel: Counsel02) {
        self.counsel = counsel
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
                        Text("상담기록").foregroundColor(.gray).font(.system(size: 13))
                        Spacer()
                        Image(systemName: "clock.arrow.circlepath").font(.system(size: 13)).foregroundColor(.gray)
                        TextField("상담시간", text: $counselViewModelData.time)
                            .frame(width: 50).font(.system(size: 13))
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    HStack {
                        // AddCounselView 와 height가 다른 이유: 300으로 하면 1번 학생 안보임
                        TextEditor(text: $counselViewModelData.content).frame(height:200).fixedSize(horizontal: false, vertical: true)
                            // 텍스트에디터가 키보드에 가리는거 방지
    //                        .background(GeometryGetter(rect: $kGuardian.rects[0]))

                    }
                    .padding(.horizontal)
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
                            counselViewModelData.number = self.selections.joined(separator: "/")
                            counselViewModelData.count = self.selections.count
                            counselViewModelData.updData(presentation: presentation)
                        }, label: {
                            if self.selections.count != 0 && counselViewModelData.content != "" {
                                Text("완료")
                            }
                        })
                    } // ToolbarItem
                } // toolbar
                .onAppear(perform: {
                    counselViewModelData.updateObject = self.counsel
                    counselViewModelData.setUpInitialData()
                    self.selections = self.counsel.number.components(separatedBy: "/")
                })
                .onDisappear(perform: {
                    counselViewModelData.deInitData()
                    // .navigationViewStyle(StackNavigationViewStyle()) 이거때문. 아이패드와 같은 화면되게하려면 어쩔수없음 ㅠㅠ
//                    presentation.wrappedValue.dismiss()
                    // DispatchQueue 이거 안쓰고 그냥 dismiss 하면 크래시 남.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        presentation.wrappedValue.dismiss()
                    }
                })
                
                Spacer()
                
                VStack {
                    Text("길게 눌러 삭제하기").foregroundColor(.red)
                        .onLongPressGesture(minimumDuration: 1) {
                            counselViewModelData.deleteData(object: counsel, presentation: presentation)
                        }
//                    Button(action: {counselViewModelData.deleteData(object: counsel, presentation: presentation)}, label: { Text("삭제").foregroundColor(.red) })
                }
                .padding()
            } // Vstack
    //            .padding()
            
        }
        
        

            
    }
}

//struct DetailCounselView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCounselView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
