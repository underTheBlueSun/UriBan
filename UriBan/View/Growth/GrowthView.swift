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
    
    @Environment(\.presentationMode) var presentaion
    
//    init(uribanID: String, uribanClassName: String) {
//        self.uribanID = uribanID
//        self.uribanClassName = uribanClassName
//    }
    
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
                            Text(growth.content)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .background(Color.white)
            .navigationBarTitle(homeViewModelData.className, displayMode: .inline)
//            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
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

