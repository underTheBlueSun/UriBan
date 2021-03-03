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
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    
    @Environment(\.presentationMode) var presentation
        
    @Namespace var animation
    
    var student: Student05
    
    // 프로필 사진
    @State var images: [UIImage] = []
    @State private var isPresented: Bool = false
    @State var openChartView = false
    
    // sheet를 멀티로 띄우기 위해
    @State var activeSheet: ActiveSheet2?

        
    init(student: Student05) {
        self.student = student
    }
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    
                    if !images.isEmpty {
//                        Button(action: {isPresented.toggle()}, label: {
                        Button(action: {
                                activeSheet = .first
//                            isPresented.toggle()
                            
                        }, label: {
                            // 프로필 사진 선택후 다시 선택할때
                            Image(uiImage: images[images.endIndex-1])
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 100, height: 110)
                        })
                    }
                    else {
//                        Button(action: {isPresented.toggle()}, label: {
                        Button(action: {
                                activeSheet = .first
//                            isPresented.toggle()
                        }, label: {
                            Image("profile02")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 100, height: 110)
                        })
                    }
                    
                    VStack {
                        HStack(spacing: 6) {
                            Image(systemName: String(student.number) + ".circle.fill").resizable().frame(width: 22, height: 22).foregroundColor(.systemTeal)
                            TextField("성명", text: $studentViewModelData.name).font(.system(size: 30, weight: .heavy)).frame(width: 105)
                            Spacer()
                            HStack(spacing: 0) {
                                TabButton(selected: $studentViewModelData.sex, title: "남자", animation: animation, gubun: 1)
                                TabButton(selected: $studentViewModelData.sex, title: "여자", animation: animation, gubun: 2)
                            }
                            .frame(width: 80)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Capsule())
                            .padding(.horizontal, 1)
                        }
                        .padding(.bottom, 2)
                        HStack {
                            Image(systemName: "phone.fill").font(.system(size: 15)).foregroundColor(.gray).padding(.horizontal,1)
                            TextField("전호번호", text: $studentViewModelData.telNo)
                                .keyboardType(.phonePad)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Image(systemName: "house.fill").font(.system(size: 15)).foregroundColor(.gray)
                            TextField("주소", text: $studentViewModelData.address).font(.system(size: 15)).foregroundColor(.gray)
                        }
                        
                        Spacer()
                    } // Vstack
                } // Hstack
                .padding(.horizontal,2)
                .padding(.vertical, 2)
                
                Divider()
                
                VStack(spacing: 0) {
                    HStack {
                        Text("메모").foregroundColor(.gray).font(.system(size: 13))
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $studentViewModelData.memo).font(.system(size: 15)).frame(height: 180)
                    }
                    
                } // Vstack
                .padding(.horizontal)
                
                Divider()
                
                VStack {
                    HStack {
//                        NavigationLink(destination: GrowthChartStu(uuid: student.uuid, number: student.number, name: student.name) ) {
//                            Image(systemName: "chart.bar.xaxis").foregroundColor(Color.red)
//                            Text("관찰 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
//                            Spacer()
//                        }
                        Button(action: { activeSheet = .second }, label: {
                            Image(systemName: "chart.bar.xaxis").foregroundColor(Color.red)
                            Text("관찰 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
                            Spacer()
                        })
                    }
                    Divider()
                    HStack {
//                        NavigationLink(destination: SubjectChartStu(uuid: student.uuid, number: student.number, name: student.name)) {
//                            Image(systemName: "chart.pie.fill").foregroundColor(Color.orange)
//                            Text("과제 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
//                            Spacer()
//                        }
                        Button(action: { activeSheet = .third }, label: {
                            Image(systemName: "chart.pie.fill").foregroundColor(Color.orange)
                            Text("과제/알림장 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
                            Spacer()
                        })
                    }
                    Divider()
                    HStack {
//                        NavigationLink(destination: CounselChartStu(uuid: student.uuid, number: student.number, name: student.name) ) {
//                            Image(systemName: "chart.bar.fill").foregroundColor(Color.green)
//                            Text("상담 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
//                            Spacer()
//                        }
                        Button(action: { activeSheet = .fourth }, label: {
                            Image(systemName: "chart.bar.fill").foregroundColor(Color.green)
                            Text("상담 누가기록 보기").foregroundColor(Color.tabbarBackgroud)
                            Spacer()
                        })
                    }
                    Divider()

                }
                .padding()
                
                Spacer()
            } // Vstack
            .padding()
            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            studentViewModelData.updateObject = nil
                            presentation.wrappedValue.dismiss()

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
                        studentViewModelData.updData(presentation: presentation)
                        
                    }, label: {
                        Text("완료")
                    })
                } // ToolbarItem
            } // toolbar
            .onAppear(perform: {
                studentViewModelData.updateObject = self.student
                images.append(UIImage(data: student.picture as Data) ?? UIImage(imageLiteralResourceName: "profile02"))
                studentViewModelData.setUpInitialData()
                // 월별 관찰 통계
                growthViewModelData.fetchPositiveByMonth(uuid: student.uuid)
                growthViewModelData.fetchNegativeByMonth(uuid: student.uuid)

            })
            .onDisappear(perform: {
                studentViewModelData.deInitData()
                // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                // .navigationViewStyle(StackNavigationViewStyle()) 이거때문. 아이패드와 같은 화면되게하려면 어쩔수없음 ㅠㅠ
                // DispatchQueue 이거 안쓰고 그냥 dismiss 하면 크래시 남.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    presentation.wrappedValue.dismiss()
                }
            })
//            .fullScreenCover(isPresented: $isPresented) {
//                                let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//                                PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
//            }
            .fullScreenCover(item: $activeSheet) { item in
                    switch item {
                        case .first:
                            let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                            PhotoPicker(images: $images, configuration: configuration, isPresented: $isPresented)
                            
                    case .second:
                        GrowthChartStu(uuid: student.uuid, number: student.number, name: student.name)
//                        SwiftUIView()
                    case .third:
                        SubjectChartStu(uuid: student.uuid, number: student.number, name: student.name)
//                        SwiftUIView2()
                        
                    case .fourth:
                        CounselChartStu(uuid: student.uuid, number: student.number, name: student.name)
//                        SwiftUIView3()
                    }
            }

        } // ScrollView

    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}

enum ActiveSheet2: Identifiable {
    case first, second, third, fourth
    
    var id: Int {
        hashValue
    }
}
