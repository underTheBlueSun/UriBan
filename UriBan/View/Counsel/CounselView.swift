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
    
    private func getDate(format: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let current_date_string = formatter.string(from: format)
        return current_date_string
    }
    
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
                            Text(counsel.content).frame(width: 250, height: 20, alignment: .leading)
                            VStack {
                                Text(getDate(format: counsel.yymmdd)).frame(alignment: .trailing)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                                Spacer()
                            }
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
                        if studentViewModelData.students.count != 0 { Image(systemName: "plus.circle.fill").font(.title2).foregroundColor(.white) }
                    })
                } // ToolbarItem
            } // toolbar
            
        } // NavigationView
//        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $counselViewModelData.openNewPage) {
            AddCounselView()
                .environmentObject(studentViewModelData)
                .environmentObject(counselViewModelData)
                .environmentObject(homeViewModelData)
        }
        .onAppear() {
            counselViewModelData.fetchData(uuid: homeViewModelData.uribanID)
        }
        .navigationViewStyle(StackNavigationViewStyle())

        
   } // body
}

//struct counselView_Previews: PreviewProvider {
//    static var previews: some View {
//        counselView().environmentObject(HomeViewModel())
//    }
//}
