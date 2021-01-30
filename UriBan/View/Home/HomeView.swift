//
//  HomeView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/18.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
// ㅃㅃㅃㅂ

import SwiftUI

struct HomeView: View {
    
    // fetch..
    @StateObject var homeViewModelData = HomeViewModel()
    
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    @State var showingActionSheet = false
    
    var titles: [String] = ["수정하기", "삭제하기", "취소하기"]
    var buttonsArray: NSMutableArray = NSMutableArray()
    
    func loadArray(home: Home03) {
        self.showingActionSheet = true
        
//            for i in 0..<self.titles.count {
//                let button: ActionSheet.Button = .default(Text(self.titles[i])) {
//                    print(self.titles[i])
//                }
//
//                self.buttonsArray[i] = button
//            }
        
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
        
//            self.buttonsArray[0] = .default(Text("수정하기"))
//            self.buttonsArray[1] = .default(Text("삭제하기"))
    }
    
    
    var body: some View {

        NavigationView {

//            ScrollView {
            ScrollView {

                LazyVGrid(columns: columns, spacing: 15) {

                    ForEach(homeViewModelData.homes) { home in


                        ZStack {

                            VStack {

                                NavigationLink(destination: StudentView(uuid: home.uuid)) {
//                                  NavigationLink( destination: StudentView(),isActive: $selectedImage) {
                                    
                                    Image(home.image)
                                        .resizable()
                                        .frame(width: 150, height: 100)
                                        .cornerRadius(15)
//                                        .onTapGesture {
//                                            selectedImage.toggle()
//                                        }
                                } // NavigationLink
                                
                                    Text(home.year + "학년도")
                                    Text(home.school)
                                    Text(home.className)
                                    



                            } // VStack
                            .padding()

                            VStack {

//                                Button(action: {  }) {
                                Button(action: { loadArray(home: home) }) {
                                    Image(systemName: "pencil.circle.fill").foregroundColor(.white).frame(height: 30).padding()
                                }
                                .actionSheet( isPresented: $showingActionSheet ) {
                                    ActionSheet( title: Text("Title"), message: Text("message"),
//                                                 buttons: [ .default(Text("수정하기")) { },
//                                                           .default(Text("삭제하기")),
//                                                           .cancel(Text("취소하기")) ]
                                                 buttons: self.buttonsArray as! [ActionSheet.Button]
                                    )
                                } // actionSheet

                                Spacer()

                            } // VStack
                            .frame(width: 170, alignment: .trailing)
//                            .contextMenu(menuItems: {
//                                //homeViewModelData.deleteData(class) 에러 남
//                                Button(action: {homeViewModelData.deleteData(object: home)}, label: {
//                                    Text("삭제하기")
//                                })
//                                Button(action: {
//                                    homeViewModelData.updateObject = home
//                                    homeViewModelData.openNewPage.toggle()}, label: {
//                                    Text("수정하기")
//                                })
//                            }) // contextMenu

                        } // ZStack

                    } // ForEach

                } // LazyVGrid

            } // ScrollView
            .background(Color.systemTeal)
            .navigationBarTitle("홈", displayMode: .inline)
            .navigationBarColor(backgroundColor: .systemTeal, tintColor: .white)
            .navigationBarItems(trailing: Button(action: {homeViewModelData.openNewPage.toggle()}) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            })
            .sheet(isPresented: $homeViewModelData.openNewPage) {
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

struct NavigationBarColor: ViewModifier {

  init(backgroundColor: UIColor, tintColor: UIColor) {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                   
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = tintColor
  }

  func body(content: Content) -> some View {
    content
  }
}

extension View {
  func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
    self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
  }
}


