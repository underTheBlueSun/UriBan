//
//  AddGrowthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/13.
//

import SwiftUI
import PhotosUI

struct AddGrowthView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @Environment(\.presentationMode) var presentaion
    
    @State var selections: [String] = []
    
    @Namespace var animation
    
    var uribanClassName: String
        
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 25), count: 10)
    
    init(uribanClassName: String) {
        self.uribanClassName = uribanClassName
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("관찰기록").foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $growthViewModelData.content).frame(height:100)
                    }
                }
                Divider()
                Button(action: { print(self.selections.joined(separator: "/")) }, label: {
                                Text("Button")
                            })
//                List {
                    
                    LazyHGrid(rows: columns, spacing: 15) {
                        ForEach(studentViewModelData.students, id: \.self) { student in
                            HStack {
                                Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                                Text(student.name)
                                let number = String(student.number)
                                MultiSelectRow(title: number, isSelected: self.selections.contains(number)) {
                                    if self.selections.contains(number) {
                                        self.selections.removeAll(where: { $0 == number })
                                    }
                                    else {
                                        self.selections.append(number)
                                    }
                                } // MultiSelectRow
                            } // HStack
    //
                        } // ForEach
                        
                    }

                    


                    
//                } // List
                .padding()
                .navigationBarTitle(uribanClassName, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
        //                        studentViewModelData.updateObject = nil
                                presentaion.wrappedValue.dismiss()

                        }, label: {
                            Text("취소")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { growthViewModelData.updData(presentation: presentaion) }, label: {
                            Text("완료")
                        })
                    } // ToolbarItem
                } // toolbar
                .onAppear(perform: {
        //            studentViewModelData.updateObject = self.student
        //            studentViewModelData.setUpInitialData()
                })
                .onDisappear(perform: {
                    // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                    presentaion.wrappedValue.dismiss()
                })
            } // Vstack
            .padding()
            
        } // NavigationView
        
        

    }
}

struct AddGrowthView_Previews: PreviewProvider {
    static var previews: some View {
        AddGrowthView(uribanClassName: "5-2반")
            .environmentObject(StudentViewModel())
            .environmentObject(GrowthViewModel())
    }
}


