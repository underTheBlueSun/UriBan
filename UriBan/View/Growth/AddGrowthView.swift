//
//  AddGrowthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI

struct AddGrowthView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @State var selections: [String] = []
    
    @Namespace var animation
    
//    var uribanClassName: String
        
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    // .fixed(30) 안하고 .flexible() 하면 세로로 꽉 채움
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 10)
    
//    init(uribanClassName: String) {
//        self.uribanClassName = uribanClassName
//    }
    
    var body: some View {
        
        NavigationView {
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
                        Text("관찰기록").foregroundColor(.gray)
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
                        TextEditor(text: $growthViewModelData.content).frame(height:110).fixedSize(horizontal: false, vertical: true)
//                        FirstResponderTextEditor(text: $growthViewModelData.content).frame(height:150).fixedSize(horizontal: false, vertical: true)
                    }
                } // VStack
                .padding(.horizontal)
                .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
        //                        studentViewModelData.updateObject = nil
                                presentation.wrappedValue.dismiss()

                        }, label: {
                            Text("취소")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Growth03 만들어서 number를 String으로 바꾼후 growthViewModelData.number 로 고쳐야 함
                            // + "/" 을 붙힌 이유: 1을 조회하는데 11 ~19 애들이 나오면 안되니깐
//                                growthViewModelData.name = "/" + self.selections.joined(separator: "/") + "/"
                            growthViewModelData.name = self.selections.joined(separator: "/")
                            growthViewModelData.addData(uuid: homeViewModelData.uribanID , presentation: presentation)
                            
                        }, label: {
                            Text("완료")
                        })
                    } // ToolbarItem
                } // toolbar
                .onAppear(perform: {
        //            studentViewModelData.updateObject = self.student
        //            studentViewModelData.setUpInitialData()
                })
                .onDisappear(perform: {
                    growthViewModelData.deInitData()
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

struct AddGrowthView_Previews: PreviewProvider {
    static var previews: some View {
        AddGrowthView()
            .environmentObject(StudentViewModel())
            .environmentObject(GrowthViewModel())
            .environmentObject(HomeViewModel())
    }
}




