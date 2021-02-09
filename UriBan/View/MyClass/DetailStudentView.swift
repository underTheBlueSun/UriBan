//
//  DetailStudentView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/07.
//


import SwiftUI
import PhotosUI

struct DetailStudentView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @Environment(\.presentationMode) var presentaion
    
    @Namespace var animation
    
//    var uuid: String = ""
//    var year: String = ""
//    var school: String = ""
//    var className: String = ""
//    var studentNum: Int = 0
//    var myClass: Bool = false
    
    var student: Student04
    
    // 프로필 사진
    @State var images: [UIImage] = []
    @State private var isPresented: Bool = false
    
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    
//    init(student: Student04) {
        // 에러 나서 onAppear 에 적음
//        studentViewModelData.updateObject = student
//    }
    
    var body: some View {

        NavigationView {
            VStack {
                HStack {
                    Button(action: {isPresented.toggle()}, label: {
                        let pictureImg = UIImage(data: student.picture as Data)
                        Image(uiImage: (pictureImg ?? UIImage(imageLiteralResourceName: "profile02")))
                            .resizable()
                            .frame(width: 100, height: 110)
                    })
                    VStack {
                        HStack(spacing: 6) {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                            TextField("성명", text: $studentViewModelData.name, onEditingChanged: { editing in self.isValidName = editing ? false : !studentViewModelData.name.isEmpty}, onCommit: { studentViewModelData.name = studentViewModelData.name.trimmingCharacters(in: .whitespaces) })
                            Spacer()
                            HStack(spacing: 0) {
                                TabButton(selected: $studentViewModelData.sex, title: "남자", animation: animation)
                                TabButton(selected: $studentViewModelData.sex, title: "여자", animation: animation)
                            }
                            .frame(width: 80)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                        }
                        HStack {
                            Image(systemName: "phone.circle.fill").resizable().frame(width: 17, height: 17).foregroundColor(.gray)
                            TextField("전호번호", text: $studentViewModelData.telNo).keyboardType(.phonePad)
                        }
                        HStack {
                            Image(systemName: "house.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                            TextField("주소", text: $studentViewModelData.address)
                        }
                    } // Vstack
                } // Hstack
                .sheet(isPresented: $isPresented) {
                                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                    PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
                }
                
                VStack(spacing: 0) {
                    HStack {
                        Text("메모").foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $studentViewModelData.memo).fixedSize(horizontal: false, vertical: true)
                    
                        
                    }
                }
                
                Text("행동발달 보기")
                
                Spacer()
                
            } // Vstack
            .padding()
            .navigationBarTitle(studentViewModelData.className, displayMode: .inline)
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
                    // 성명을 입력해야 완료 버튼 활성화
                    if isValidName {
                        Button(action: {
                            if !images.isEmpty {
                                studentViewModelData.picture = images[0]
                            }
                            studentViewModelData.addData(presentation: presentaion)
                            
                        }, label: {
                            Text("완료")
                        })
                    }

                }
            } // toolbar
//            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onAppear(perform: {
                studentViewModelData.updateObject = student
                studentViewModelData.setUpInitialData()
            })
            .onDisappear(perform: studentViewModelData.deInitData)
        
        } // NavigationView

        
    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(uuid: "", className: "5-2반", studentCnt: 23)
//            .environmentObject(StudentViewModel())
//    }
//}
