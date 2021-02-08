//
//  HomeView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/18.
//  Copyright © 2021 underTheBlueSun. All rights reserved.

import SwiftUI

struct HomeView: View {

    // 초기화 하면서 fetch 한다
    @StateObject var homeViewModelData = HomeViewModel()
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State var showingActionSheet = false
    var titles: [String] = ["수정하기", "삭제하기", "취소하기"]
    var buttonsArray: NSMutableArray = NSMutableArray()
    
    func loadArray(home: Home03) {
        self.showingActionSheet = true
        // 수정하기
        let button0: ActionSheet.Button = .default(Text(self.titles[0])) {
            homeViewModelData.updateObject = home
            homeViewModelData.openNewPage.toggle()
        }
        // 삭제하기
        let button1: ActionSheet.Button = .default(Text(self.titles[1])) {
            homeViewModelData.deleteData(object: home)
        }
        // 취소하기
        let button2: ActionSheet.Button = .cancel(Text(self.titles[2]))
        self.buttonsArray[0] = button0
        self.buttonsArray[1] = button1
        self.buttonsArray[2] = button2
    }
    
    var body: some View {

        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(homeViewModelData.homes) { home in
                        ZStack {
                            VStack {
                                NavigationLink(destination: NavigationLazyView(StudentView(uuid: home.uuid, year: home.year, school: home.school, className: home.className, myClass: home.myClass))) {
                                    Image(home.image)
                                        .resizable()
                                        .frame(width: 150, height: 100)
                                        .cornerRadius(15)
                                        
                                } // NavigationLink
                                .simultaneousGesture(TapGesture().onEnded {
                                                    print("TAPPED")
                                })
                                
                                Text(home.year + ". " + home.school).font(.system(size: 14))
//                                    Text(home.school).font(.system(size: 14))
                                    Text(home.className).font(.system(size: 14))
                            } // VStack
                            .padding()
                            VStack {
                                Button(action: { loadArray(home: home) }) {
                                    Image(systemName: "pencil.circle.fill").foregroundColor(.white).frame(height: 30).padding()
                                }
                                .actionSheet( isPresented: $showingActionSheet ) {
                                    ActionSheet( title: Text("홈"), buttons: self.buttonsArray as! [ActionSheet.Button] )
                                } // actionSheet
                                Spacer()
                            } // VStack
                            .frame(width: 170, alignment: .trailing)
                        } // ZStack
                    } // ForEach
                } // LazyVGrid
            } // ScrollView
            .background(Color.white)
            .navigationBarTitle("홈", displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .navigationBarItems(trailing: Button(action: {homeViewModelData.openNewPage.toggle()}) {
                if homeViewModelData.homes.count > 10 {
                    
                }
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            })
            .fullScreenCover(isPresented: $homeViewModelData.openNewPage) {
                AddHomePageView()
                    .environmentObject(homeViewModelData)
            }
        } // NavigationView

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




