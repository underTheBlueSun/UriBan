//
//  DetailStudentView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/07.
//


import SwiftUI
import PhotosUI
import SwiftUICharts

struct DetailStudentView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    
    @Environment(\.presentationMode) var presentaion
        
    @Namespace var animation
    
    var student: Student05
    
    // 프로필 사진
    @State var images: [UIImage] = []
    @State private var isPresented: Bool = false
        
    init(student: Student05) {
         
        self.student = student
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    
                    if !images.isEmpty {
                        Button(action: {isPresented.toggle()}, label: {
                            // 프로필 사진 선택후 다시 선택할때
                            Image(uiImage: images[images.endIndex-1])
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 100, height: 110)
                        })
                    }
                    else {
                        Button(action: {isPresented.toggle()}, label: {
                            Image("profile02")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 100, height: 110)
                        })
                    }
                    
                    VStack {
                        HStack(spacing: 6) {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 20, height: 20).foregroundColor(.systemTeal)
                            // 메모에는 어떻게 onEditingChanged를 붙힐지 몰라서 완료버튼 풀어버림.
    //                        TextField("성명", text: $studentViewModelData.name, onEditingChanged: { editing in self.isValidName = editing ? false : !studentViewModelData.name.isEmpty},
                            TextField("성명", text: $studentViewModelData.name).font(.system(size: 23))
                            Spacer()
                            HStack(spacing: 0) {
                                TabButton(selected: $studentViewModelData.sex, title: "남자", animation: animation, gubun: 1)
                                TabButton(selected: $studentViewModelData.sex, title: "여자", animation: animation, gubun: 2)
                            }
                            .frame(width: 80)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Capsule())
                            .padding(.horizontal)
                        }
                        HStack {
                            TextField("전호번호", text: $studentViewModelData.telNo).keyboardType(.phonePad).font(.system(size: 15)).foregroundColor(.gray)
                        }
                        HStack {
                            TextField("주소", text: $studentViewModelData.address).font(.system(size: 15)).foregroundColor(.gray)
                        }
                    } // Vstack
                } // Hstack
                .sheet(isPresented: $isPresented) {
                                    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                    PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
                }
                Divider()
                VStack(spacing: 0) {
                    HStack {
                        Text("메모").foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $studentViewModelData.memo).font(.system(size: 20)).frame(height: 100)
                    }
                }
                
                Text("행동발달 보기")
                MultiLineChartView(data: [(growthViewModelData.groupedToArrPositive, GradientColors.blue), (growthViewModelData.groupedToArrNegative, GradientColors.orngPink)], title: "월별 관찰추이")
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
                        Text("")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !images.isEmpty {
    //                        studentViewModelData.picture = images[0]
                            studentViewModelData.picture = images[images.endIndex-1]
                        }
                        studentViewModelData.updData(presentation: presentaion)
                        
                    }, label: {
                        Text("완료")
                    })
                } // ToolbarItem
            } // toolbar
    //            .onAppear(perform: studentViewModelData.setUpInitialData)
            .onAppear(perform: {
                studentViewModelData.updateObject = self.student
    //            images[0] = UIImage(data: student.picture as Data) ?? UIImage(imageLiteralResourceName: "profile02")
    //            images[0] = UIImage(systemName: "pencil")!
                images.append(UIImage(data: student.picture as Data) ?? UIImage(imageLiteralResourceName: "profile02"))
                studentViewModelData.setUpInitialData()
                // 월별 관찰 통계
                growthViewModelData.fetchPositiveByGroup(uuid: student.uuid)
                growthViewModelData.fetchNegativeByGroup(uuid: student.uuid)

            })
            .onDisappear(perform: {
                studentViewModelData.deInitData()
                // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                presentaion.wrappedValue.dismiss()
            })
        }
        
        

    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
