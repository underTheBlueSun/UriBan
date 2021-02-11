//
//  MainTabView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/18.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    // 앱이 활성화 되면 우리반 uuid를 변수에 저장
    @StateObject var homeViewModelData = HomeViewModel()
    
    init() {
        // 탭바 배경 색깔 변경. 2021.1월 iOS 14.3 버그로 추정
//        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.tertiaryLabel
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
  private enum Tabs {
    case home, myclass, growth, subject, counsel
  }
  
  @State private var selectedTab: Tabs = .home
    
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
        
      Group {
        home
        myclass
        growth
        subject
        counsel
      }
      
    }
    .accentColor(.systemTeal)
    .edgesIgnoringSafeArea(.top)
    .onAppear(perform: {
        // 앱이 활성화 되면 우리반 uuid를 변수에 저장
        homeViewModelData.fetchUriBanData()
    })
  }
}

private extension MainTabView {
    
    var home: some View {
      
      HomeView().environmentObject(homeViewModelData)
        .tag(Tabs.home)
        .tabItem {
          Image(systemName: "house.fill")
          Text("홈")
         }
    }
    
    
  var myclass: some View {
    
    UriBanView(uribanID: homeViewModelData.uribanID, uribanClassName: homeViewModelData.uribanClassName)
//    UriBanView().environmentObject(homeViewModelData)
      .tag(Tabs.myclass)
      .tabItem {
        Image(systemName: "person.2.fill")
        Text("우리반")
       }
  }
    
    var growth: some View {
      Text("행발")
        .tag(Tabs.growth)
          .tabItem {
              Image(systemName: "rectangle.stack.person.crop.fill")
              Text("행발")
          }
    }
  
  var subject: some View {
    Text("과제")
      .tag(Tabs.subject)
        .tabItem {
            Image(systemName: "text.badge.checkmark")
            Text("과제")
        }
  }
  
  var counsel: some View {
    Text("상담")
      .tag(Tabs.counsel)
        .tabItem {
            Image(systemName: "doc.text.magnifyingglass")
            Text("상담")
        }
  }
    
}


// MARK: - View Extension

//fileprivate extension View {
//  func tabItem(image: String, text: String) -> some View {
//    self.tabItem {
//      Symbol(image, scale: .large)
//        .font(Font.system(size: 17, weight: .light))
//      Text(text)
//    }
//  }
//}


// MARK: - Preview

struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
//    Preview(source: MainTabView())
//      .environmentObject(Store())
    MainTabView()
  }
}
