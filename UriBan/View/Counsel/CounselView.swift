//
//  CounselView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/02/27.
//

import SwiftUI

struct CounselView: View {
    
    @EnvironmentObject var studentViewModelData: StudentViewModel
    @EnvironmentObject var homeViewModelData: HomeViewModel
    @EnvironmentObject var counselViewModelData: CounselViewModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(counselViewModelData.counsels) { counsel in
                    NavigationLink(destination:
                                    DetailCounselView(counsel: counsel)
                                    .environmentObject(homeViewModelData)
                                    .environmentObject(studentViewModelData)
                                    .environmentObject(counselViewModelData)) {
                        HStack {
                            Text(counsel.content).frame(width: 300, height: 15, alignment: .leading)
                        } // Hstack
                    } // NavigationLink
                } // ForEach
            } // List
            .background(Color.white)
            .navigationBarTitle(homeViewModelData.uribanClassName, displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        counselViewModelData.openNewPage.toggle()
                    }, label: {
                        if homeViewModelData.uribanID != "" { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
                    })
                } // ToolbarItem
            } // toolbar
            
        } // NavigationView
        .fullScreenCover(isPresented: $counselViewModelData.openNewPage) {
            AddCounselView()
                .environmentObject(studentViewModelData)
                .environmentObject(counselViewModelData)
                .environmentObject(homeViewModelData)
        }
        .onAppear() {
            counselViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }

        
   } // body
}

//struct counselView_Previews: PreviewProvider {
//    static var previews: some View {
//        counselView().environmentObject(HomeViewModel())
//    }
//}
