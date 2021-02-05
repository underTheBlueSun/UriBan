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
    // 남녀 토글버튼
//    @State var tab = "남자"
    @Namespace var animation
    
//    var uuid: String = ""
//    var year: String = ""
//    var school: String = ""
    var className: String = ""
    var studentNum: Int = 0
//    var myClass: Bool = false

//    init(uuid: String, year: String, school: String, className: String, myClass: Bool) {
//        self.uuid = uuid
//        self.year = year
//        self.school = school
//        self.className = className
//        self.myClass = myClass
//    }
    
    init(className: String, studentCnt: Int) {
        self.className = className
        self.studentNum = studentCnt + 1
        
    }
    
    var body: some View {

        NavigationView {
            VStack {
                HStack {
                    Image("profile02")
                        .resizable()
                        .frame(width: 100, height: 120)
                    VStack {
                        HStack {
                            Image(systemName: "number.square.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
//                            Text(String(studentNum) + "번")
                            TextField("", text: $studentViewModelData.number)
                            Text("번")
                            Spacer()
                            HStack(spacing: 0) {
                                TabButton(selected: $studentViewModelData.sex, title: "남자", animation: animation)
                                TabButton(selected: $studentViewModelData.sex, title: "여자", animation: animation)
                            }
                            .frame(width: 90)
                            .background(Color.gray.opacity(0.08))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Image(systemName: "person.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                            TextField("이름을 입력하세요", text: $studentViewModelData.name)
                        }
                        HStack {
                            Image(systemName: "phone.circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                            TextField("전호번호를 입력하세요", text: $studentViewModelData.telNo).keyboardType(.phonePad)
                        }
                    } // Vstack
                } // Hstack
                
                HStack {
                    Image(systemName: "house.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                    TextField("주소를 입력하세요", text: $studentViewModelData.address)
                }
                
                Spacer()
                
            } // Vstack
            .padding()
            .navigationBarTitle(className, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            studentViewModelData.updateObject = nil
                            presentaion.wrappedValue.dismiss()

                    }, label: {
                        Text("취소")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {studentViewModelData.addData(presentation: presentaion)}, label: {
                        Text("완료")
                    })
                }
            } // toolbar
//            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onAppear(perform: {
                // int() 에 적으면 에러남. 번호는 int로 해야 나중에 sort 유리하지 않나..
                        studentViewModelData.number = String(studentNum)
                
            })
            .onDisappear(perform: studentViewModelData.deInitData)
            
            
        
        } // NavigationView

        
    }
}

struct AddStudentPageView_Previews: PreviewProvider {
    static var previews: some View {
//        AddStudentPageView(uuid: "", year: "", school: "", className: "", myClass: false)
        AddStudentPageView(className: "5-2반", studentCnt: 1)
            .environmentObject(StudentViewModel())
    }
}
