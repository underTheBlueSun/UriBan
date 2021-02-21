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
    @State var openChartView = false
        
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
                            TextField("성명", text: $studentViewModelData.name).font(.system(size: 23)).frame(width: 80)
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
                        Text("메모").foregroundColor(.gray).font(.system(size: 15))
                        Spacer()
                    }
                    HStack {
                        TextEditor(text: $studentViewModelData.memo).font(.system(size: 15)).frame(height: 180)
                    }
                    
//                    BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "월별관찰현황", form: ChartForm.large)
                } // Vstack
//                .padding(.horizontal)
                Divider()
                
                HStack {
                    ZStack {
                        // 월별 관찰 차트
                        BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.small)
                        
                        
                        Button(action: {
                                    self.openChartView.toggle()
                            
                        }, label: {
//                            Rectangle().foregroundColor(Color.red).frame(width: 100, height: 100)
                            Text("터치하여 상세관찰보기").font(.system(size: 10)).foregroundColor(Color.gray)
                        })
                        
                        
                        
                    }
                    
                    
                    BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.small)
                } // Hstack
                Divider()
                HStack {
                    // 과제 달성율
                    VStack {
                        HStack {
                            Text("과제달성율").bold().font(.system(size: 16))
    //                        Text("터치하여 월별통계보기").font(.system(size: 10)).foregroundColor(Color.gray)
                            Spacer()
                        }
                        ZStack {
                            Circle()
                                .trim(from: 0, to: 1 )
                                .stroke(Color.green.opacity(0.07), lineWidth: 10)
                                .frame(width: 147, height: 55)
//                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                            Circle()
                                .trim(from: 0, to: ( 10 / 24) )
                                .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                .frame(width: 147, height: 55)
//                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                            Text(getPercent(current: 10, goal: 24) + "%")
                                .font(.system(size: 17))
                                .rotationEffect(.init(degrees: 90))

                        } // ZStack
                        .rotationEffect(.init(degrees: -90))
                    } // VStack
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray.opacity(0.7), radius: 10)
                    
                    // 상담
                    Button(action: {
//                                self.openChartView.toggle()
                        
                    }, label: {
                        BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", form: ChartForm.small)
                    })

                    
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
                growthViewModelData.fetchPositiveByMonth(uuid: student.uuid)
                growthViewModelData.fetchNegativeByMonth(uuid: student.uuid)

            })
            .onDisappear(perform: {
                studentViewModelData.deInitData()
                // 상세화면에 있다가 다른 곳 탭한후 다시 탭하면 rootview로 돌아가려고
                presentaion.wrappedValue.dismiss()
            })
            .fullScreenCover(isPresented: $openChartView) {
                GrowthChartView(uuid: self.student.uuid, className: homeViewModelData.className)
            } // fullScreenCover
        }
        
        

    }
}

//struct DetailStudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStudentView(student: Student04)
//            .environmentObject(StudentViewModel())
//    }
//}
