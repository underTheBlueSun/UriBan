//
//  GrowthView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/12.
//

import SwiftUI

struct GrowthView: View {
    
//    var uribanID: String
//    var uribanClassName: String

    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var growthViewModelData: GrowthViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    
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
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(growthViewModelData.growths) { growth in
                    NavigationLink(destination:
                                    DetailGrowthView(growth: growth)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(growthViewModelData)) {
                        HStack {
                            Text(growth.content).frame(width: 220, height: 15, alignment: .leading)
                            VStack {
                                Text(getDate(format: growth.yymmdd)).frame(width: 80, height: 15, alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                            }
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .background(Color.white)
//            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar { Button(action: {growthViewModelData.openNewPage.toggle()}) {
                if homeViewModelData.uribanID != "" {
                    Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white)
                }
                
                
            }
            }
        } // NavigationView
        .fullScreenCover(isPresented: $growthViewModelData.openNewPage) {
            AddGrowthView()
                .environmentObject(studentViewModelData)
                .environmentObject(growthViewModelData)
                .environmentObject(homeViewModelData)
        }
        .onAppear() {
            growthViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }

        
   } // body
}

//struct GrowthView_Previews: PreviewProvider {
//    static var previews: some View {
//        GrowthView().environmentObject(HomeViewModel())
//    }
//}

