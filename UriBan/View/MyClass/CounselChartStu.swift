//
//  CounselChartStu.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI
import SwiftUICharts

struct CounselChartStu: View {
    
    @EnvironmentObject var counselViewModelData: CounselViewModel
    @EnvironmentObject var studentViewModelData: StudentViewModel
    
    @Environment(\.presentationMode) var presentation
    
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: format)
        return current_date_string
    }
    
    var body: some View {
        
        VStack {
            List {
                ForEach(counselViewModelData.counsels) { counsel in
                    HStack {
                        Text(counsel.content).frame(width: 280, alignment: .leading).font(.system(size: 15))
                            .frame(minWidth: 0, maxWidth: 280, minHeight: 10, maxHeight: 100)
                        VStack {
                            Text(getDate(format: counsel.yymmdd))
                                .frame(alignment: .trailing)
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                            Spacer()
                            Text(counsel.time)
                                .frame(alignment: .trailing)
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                        }
                    }

                } // ForEach

            } // List
        } // VStack
        .navigationBarTitle(self.name, displayMode: .inline)
        .onAppear(perform: {
        //  데이터 가져오기
            counselViewModelData.fetchStu(uuid: uuid, number: number)
        
        }) // onAppear()
        .onDisappear(perform: {
//            presentation.wrappedValue.dismiss()
            // DispatchQueue 이거 안쓰고 그냥 dismiss 하면 크래시 남.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                presentation.wrappedValue.dismiss()
            }
        })

        
    }
}

//struct CounselChartStu_Previews: PreviewProvider {
//    static var previews: some View {
//        CounselChartStu()
//    }
//}

