//
//  HomeChartView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/16.
//

import SwiftUI
import SwiftUICharts

struct HomeChartView: View {
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    @EnvironmentObject var counselViewModelData: CounselViewModel
    
    @Environment(\.presentationMode) var presentation

    var uuid: String
    var className: String
    
    @State var openChartView = false
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var arrPositive: [(String,Int)] = []
    @State var arrNegative: [(String,Int)] = []
    
    // 과제 달성율
    @State var cntGoal: CGFloat = 0
    @State var cntCurrent: CGFloat = 0
    // 상담 월별 통계
    @State var arrCounsel: [(String,Int)] = []
    
    // sheet를 멀티로 띄우기 위해
    @State var activeSheet: ActiveSheet?
    
    init(uuid: String, className: String) {
        self.uuid = uuid
        self.className = className
    }
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                

                HStack {
                    ZStack {
                        BarChartView(data: ChartData(values: arrPositive), title: "좋아요",  style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.blue, secondGradientColor: Color.blue, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                        // BarChartView 는 버튼 액션이 안먹음
                        Button(action: { activeSheet = .first }, label: {
                            Text("상세통계를 보려면 터치하세요").font(.system(size: 10)).foregroundColor(Color.gray).frame(height: 150, alignment: .top)
                        })
                    } // ZStack
                    
                    ZStack {
                        BarChartView(data: ChartData(values: arrNegative), title: "고쳐요", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                        // BarChartView 는 버튼 액션이 안먹음
                        Button(action: { activeSheet = .second }, label: {
                            Text("상세통계를 보려면 터치하세요").font(.system(size: 10)).foregroundColor(Color.gray).frame(height: 150, alignment: .top)
                        })
                    } // ZStack
                    
                    

                } // Hstack
                .padding()
                
                HStack {
                    // 과제 달성율 차트
                    Button(action: { activeSheet = .third }, label: {
                        VStack {
                            Text("과제/안내장").bold().font(.system(size: 17)).foregroundColor(.black)
                            Text("상세통계를 보려면 터치하세요").font(.system(size: 10)).foregroundColor(Color.gray)
                            ZStack {
                                Circle()
                                    .trim(from: 0, to: 1 )
                                    .stroke(Color.green.opacity(0.1), lineWidth: 10)
                                    .frame(width: 146, height: 165)
    //                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                                Circle()
                                    .trim(from: 0, to: ( cntCurrent / cntGoal) )
                                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: 146, height: 165)
    //                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                                Text(getPercent(current: cntCurrent, goal: cntGoal) + "%")
                                    .font(.system(size: 30))
                                    .rotationEffect(.init(degrees: 90))

                            } // ZStack
                            .rotationEffect(.init(degrees: -90))
                        } // VStack
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(1), radius: 10)
                    
                    })
                    
                    // 상담 차트
                    ZStack {
                        BarChartView(data: ChartData(values: arrCounsel), title: "상담", style: ChartStyle.init(backgroundColor: Color.white, accentColor: Color.red, secondGradientColor: Color.red, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), form: ChartForm.medium)
                        // BarChartView 는 버튼 액션이 안먹음
//                        Button(action: { activeSheet = .fourth }, label: {
//                            Text("터치하여 월별통계보기").font(.system(size: 10)).foregroundColor(Color.gray).frame(height: 150, alignment: .top)
//                        })
                    } // ZStack
                    
                } // HStack
                
               

            } // Vsatack
            .padding()

        } // ScrollView
        .fullScreenCover(item: $activeSheet) { item in
                switch item {
                case .first:
                    GrowthChartView(uuid: self.uuid, className: self.className)
                case .second:
                    GrowthChartView(uuid: self.uuid, className: self.className)
                case .third:
                    SubjectChartView(uuid: self.uuid, className: self.className).environmentObject(studentViewModelData)
//                case .fourth:
//                    GrowthChartView(uuid: self.uuid, className: self.className)
                }
        }
//        .fullScreenCover(isPresented: $openChartView) {
//            GrowthChartView(uuid: self.uuid, className: self.className)
//        } // fullScreenCover
        .onAppear(perform: {
            // 관찰 월별 통계 가져오기
            growthViewModelData.fetchPositiveByMonth(uuid: uuid)
            growthViewModelData.fetchNegativeByMonth(uuid: uuid)            
            // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
            self.arrPositive = growthViewModelData.groupedPositive.sorted(by: <).map { (String($0)+"월", Int($1)) }
            self.arrNegative = growthViewModelData.groupedNegative.sorted(by: <).map { (String($0)+"월", Int($1)) }
            
            // 과제목표 = 과제 총건수 * 학생수
            subjectViewModelData.fetchSubjectTotal(uuid: uuid)
            self.cntGoal = CGFloat(subjectViewModelData.cntGoal * studentViewModelData.students.count)
            // cntGoal = 0이면 nan% 라고 표시됨.
            if self.cntGoal == 0 {
                self.cntGoal = 1
            }
            self.cntCurrent = CGFloat(subjectViewModelData.cntCurrent)
            
            // 상담 월별 통계 가져오기
            counselViewModelData.fetchByMonth(uuid: uuid)
            self.arrCounsel = counselViewModelData.groupedCounsel.sorted(by: <).map { (String($0)+"월", Int($1)) }
        }) // onAppear()
        .onDisappear(perform: {
//            presentation.wrappedValue.dismiss()
            // DispatchQueue 이거 안쓰고 그냥 dismiss 하면 크래시 남.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                presentation.wrappedValue.dismiss()
            }
        })
        
    } // body
}

struct HomeChartView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartView(uuid: "3457F0C5-4517-48DD-8689-990BACF4E455", className: "5-2반")
    }
}

enum ActiveSheet: Identifiable {
    case first, second, third
    
    var id: Int {
        hashValue
    }
}
