//
//  BarChartExam.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/23.
//

import SwiftUI

struct BarChartExam: View {
    
    @State var selected = 0
    var colors = [Color.red, Color.green]
    
    var aaa: [String: Int] = ["3월": 5, "4월": 10]
    
//    func getHeight(value: CGFloat) -> CGFloat {
//        <#function body#>
//    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            
            Text("제목")
            
            HStack(spacing: 15) {
                
                ForEach(workout_Data) { work in
//                ForEach(aaa.sorted(by: <), id: \.key) { key, value in
                    
                    // bars ..
                    
                    VStack {
                        VStack {
                            
                            Spacer(minLength: 0)
                            
//                            Text("\(work.workout_In_Min)")
                            Text(String(Int(work.workout_In_Min)))
//                                Text(String(value))
                                .font(.caption)
                                .foregroundColor(Color.red)
                                .padding(.bottom,5)
                            
                            Rectangle()
//                                .fill()
                                .fill(LinearGradient(gradient: .init(colors : [Color.black]), startPoint: .top, endPoint: .bottom))
                            // max height = 200
//                                .frame(height: CGFloat(value) * 5)
                                .frame(height: work.workout_In_Min * 5)
                            
                        }
                        .frame(height: 100)
//                        .onTapGesture {
//                            withAnimation(.easeOut) {
//                                selected = work.id
//
//                            }
//                        }
                        
                        Text(work.day)
//                        Text(key)
                            .font(.caption)
                        
                    } // VStack
                    
                } // ForEach
                
            } // HStack
            
        } // VStack
        .padding()
        .background(Color.gray.opacity(0.09))
        .cornerRadius(10)
        .padding()
    }
}

struct BarChartExam_Previews: PreviewProvider {
    static var previews: some View {
        BarChartExam()
    }
}

// sample data

struct Daily: Identifiable {
    var id: Int
    var day: String
    var workout_In_Min: CGFloat
        
}

var workout_Data = [

    Daily(id: 0, day: "3월", workout_In_Min: 5),
    Daily(id: 1, day: "4월", workout_In_Min: 2),
    Daily(id: 2, day: "5월", workout_In_Min: 3),
    Daily(id: 3, day: "6월", workout_In_Min: 10),
    Daily(id: 4, day: "7월", workout_In_Min: 7),
    Daily(id: 5, day: "8월", workout_In_Min: 1),
    Daily(id: 6, day: "9월", workout_In_Min: 2),
    Daily(id: 7, day: "10월", workout_In_Min: 5),
    Daily(id: 8, day: "11월", workout_In_Min: 2),
    Daily(id: 9, day: "12월", workout_In_Min: 5)
]
