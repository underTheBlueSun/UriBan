//
//  DonutChartExam.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/21.
//

import SwiftUI

struct DonutChartExam: View {
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    var body: some View {
        VStack {
            Text("aaaaa")
            ZStack {
                Circle()
                    .trim(from: 0, to: 1 )
                    .stroke(Color.red.opacity(0.07), lineWidth: 10)
                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 300 / 2))

                Circle()
                    .trim(from: 0, to: ( 10 / 24) )
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: (UIScreen.main.bounds.width - 100) / 2, height: (UIScreen.main.bounds.width - 300 / 2))

                Text(getPercent(current: 10, goal: 24) + "%")
                    .font(.system(size: 22))
                    .rotationEffect(.init(degrees: 90))

            } // ZStack
            .rotationEffect(.init(degrees: -90))
        } // VStack
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.5), radius: 10)

    }
}

struct DonutChartExam_Previews: PreviewProvider {
    static var previews: some View {
        DonutChartExam()
    }
}

