//
//  AddStudentPageView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/31.
//

import SwiftUI
import PhotosUI

struct AddStudentView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
//    스윗한 스위프트 p303 참고
    @Environment(\.presentationMode) var presentaion
    
    @Namespace var animation
    
//    var uuid: String = ""
//    var year: String = ""
//    var school: String = ""
//    var className: String = ""
//    var myClass: Bool = false
    
    var studentNum: Int = 0
//    var uribanClassName: String = ""
    
    // 프로필 사진
    @State var images: [UIImage] = []
    @State private var isPresented: Bool = false
    
    // 성명을 입력해야 완료 버튼이 활성화 되게
    @State private var isValidName = false
    
//    init(uuid: String, className: String, studentCnt: Int) {
    init(studentCnt: Int) {
//        self.uuid = uuid
//        self.className = className
        self.studentNum = studentCnt + 1
//        self.uribanClassName = uribanClassName
        
    }
    
    var body: some View {

        NavigationView {
            VStack {
                HStack {
//                    Image("profile02")
//                        .resizable()
//                        .frame(width: 100, height: 120)
                    
                    if !images.isEmpty {
                        Button(action: {isPresented.toggle()}, label: {
//                            Image(uiImage: images[0])
                            // 프로필 사진 선택후 다시 선택할때
                            Image(uiImage: images[images.endIndex-1])
                                .resizable()
                                .frame(width: 100, height: 110)
                                .cornerRadius(10)
                        })
                    }
                    else {
                        Button(action: {isPresented.toggle()}, label: {
                            Image("profile02")
                                .resizable()
                                .frame(width: 100, height: 110)
                                .cornerRadius(10)
                        })
                    }

                    VStack {
                        HStack(spacing: 6) {
                            Image(systemName: String(studentNum) + ".circle.fill").resizable().frame(width: 25, height: 25).foregroundColor(.systemTeal)
//                            TextField("성명", text: $studentViewModelData.name, onEditingChanged: { editing in self.isValidName = true})
//                                .font(.system(size: 23))
                            // 성명 텍스트필드에 포커싱 주기
                            FirstResponderTextField(text: $studentViewModelData.name, placeholder: " 성명")
                                .font(.system(size: 23))
                                .frame(height: 30)
                            Spacer()
                            HStack(spacing: 0) {
                                TabButton(selected: $studentViewModelData.sex, title: "남자", animation: animation, gubun: 1)
                                TabButton(selected: $studentViewModelData.sex, title: "여자", animation: animation, gubun: 2)
                            }
                            .frame(width: 80)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Capsule())
//                            .padding(.horizontal)
                        }
                        
//                        HStack {
//                            Image(systemName: "person.fill").resizable().frame(width: 17, height: 17).foregroundColor(.gray)
//                            TextField("성명", text: $studentViewModelData.name)
//                        }
                        HStack {
                            Image(systemName: "phone.fill").resizable().frame(width: 17, height: 17).foregroundColor(.gray).padding(.horizontal,1)
                            TextField("전화번호", text: $studentViewModelData.telNo).keyboardType(.phonePad)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Image(systemName: "house.fill").resizable().frame(width: 20, height: 20).foregroundColor(.gray)
                            TextField("주소", text: $studentViewModelData.address)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        }
                    } // Vstack
                } // Hstack
                .sheet(isPresented: $isPresented) {
                                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                    PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
                }
                .padding(.horizontal,2)
                .padding(.vertical, 2)
                
                Divider()
                
                VStack(spacing: 0) {
                    HStack {
                        Text("메모").foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $studentViewModelData.memo).fixedSize(horizontal: false, vertical: true).font(.system(size: 15))
                    
                        
                    }
                }                
                
                Spacer()
                
            } // Vstack
            .padding()
            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
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
//                    if isValidName {
                        Button(action: {
                            if !images.isEmpty {
    //                        studentViewModelData.picture = images[0]
                                studentViewModelData.picture = images[images.endIndex-1]
                            }
                            studentViewModelData.addData(uuid: homeViewModelData.uribanID, presentation: presentaion)
                            
                        }, label: {
                            Text("완료")
                        })
//                    }

                }
            } // toolbar
//            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onAppear(perform: {
                        studentViewModelData.number = studentNum
                
            })
            .onDisappear(perform: studentViewModelData.deInitData)
        
        } // NavigationView
//        .navigationViewStyle(StackNavigationViewStyle())

        
    }
}

struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView(studentCnt: 23)
            .environmentObject(StudentViewModel())
    }
}
