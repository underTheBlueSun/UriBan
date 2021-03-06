//
//  SubjectChartStu.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/24.
//

import SwiftUI
import SwiftUICharts

struct SubjectChartStu: View {
    
    @EnvironmentObject var subjectViewModelData: SubjectViewModel
    @EnvironmentObject var studentViewModelData: StudentViewModel
    
    @Environment(\.presentationMode) var presentation
    
    // 변수로 안받으면 제일 처음 막대그래프모양이 안보임.
    @State var arrPositiveIndi: [(String,Int)] = []
    @State var arrNegativeIndi: [(String,Int)] = []
    
    // 과제 달성율
    @State var cntGoal: CGFloat = 0
    @State var cntCurrent: CGFloat = 0
    
    var uuid: String
    var number: Int
    var name: String
    
    init(uuid: String, number: Int, name: String) {
        self.uuid = uuid
        self.number = number
        self.name = name
    }
    
    // yyyy.mm.dd 가져오기
    private func getDate(format: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        let date = Date()
//        let today = dateFormatter.string(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: format)
//        print(current_date_string)
        return current_date_string
    }
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }

    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("과제/안내장").bold().font(.system(size: 17)).foregroundColor(.gray)
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 1 )
                            .stroke(Color.green.opacity(0.1), lineWidth: 10)
                            .frame(width: 100, height: 100)
//                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                        Circle()
                            .trim(from: 0, to: ( cntCurrent / cntGoal) )
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(width: 100, height: 100)
//                                .frame(width: (UIScreen.main.bounds.width) / 1.3, height: (UIScreen.main.bounds.width - 600 / 2))

                        Text(getPercent(current: cntCurrent, goal: cntGoal) + "%")
                            .font(.system(size: 27))
                            .rotationEffect(.init(degrees: 90))

                    } // ZStack
                    .rotationEffect(.init(degrees: -90))
                } // VStack
                .padding()
                .background(Color.white)
//                .cornerRadius(15)
//                .shadow(color: Color.gray.opacity(1), radius: 10)
                
                Divider()
                
                List {
                    ForEach(subjectViewModelData.subjects) { subject in
                        HStack {
                            Text(subject.content).frame(width: 280, alignment: .leading).font(.system(size: 15))
                                .frame(minWidth: 0, maxWidth: 280, minHeight: 10, maxHeight: 100)
                            VStack {
                                Text(getDate(format: subject.yymmdd))
                                    .frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                                if subject.number.contains(String(format: "%02d", self.number)) == true {
                                    Text("달성")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 12))
                                }else{
                                    Text("미달성")
                                        .foregroundColor(.red)
                                        .font(.system(size: 12))

                                    
                                }
                            }

                        }

                    } // ForEach
                } // List
//                .environment(\.defaultMinListRowHeight, 5)

                
            } // VStack
            .navigationBarTitle(self.name, displayMode: .inline)
            .onAppear(perform: {
            // 달성율 차트 가져오기
            subjectViewModelData.fetchSubjectIndi(uuid: uuid, number: number)
            self.cntGoal = CGFloat(subjectViewModelData.cntGoal)
            // cntGoal = 0이면 nan% 라고 표시됨.
            if self.cntGoal == 0 {
                self.cntGoal = 1
            }
            self.cntCurrent = CGFloat(subjectViewModelData.cntCurrent)
            
            // 전체 데이터 가져오기
            subjectViewModelData.fetchData(uuid: uuid)
            
        }) // onAppear()
            .onDisappear(perform: {
        //            presentation.wrappedValue.dismiss()
                // DispatchQueue 이거 안쓰고 그냥 dismiss 하면 크래시 남.
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    presentation.wrappedValue.dismiss()
//                }
            })
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        presentation.wrappedValue.dismiss()
//                    }
                    presentation.wrappedValue.dismiss()
                    
                }, label: { Text("닫기") })
            }
        } // toolbar

        }
    }
}

//struct SubjectChartStu_Previews: PreviewProvider {
//    static var previews: some View {
//        SubjectChartStu()
//    }
//}
