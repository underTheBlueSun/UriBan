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
    @StateObject var studentViewModelData = StudentViewModel()
    @StateObject var growthViewModelData = GrowthViewModel()
    
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
        homeViewModelData.setUriBanID()
        // UriBanView에서 @StateObject var studentViewModelData: StudentViewModel = StudentViewModel()
        // 위처럼 하면 학반추가버튼 누르면 UriBanView의 onAppear 정상 작동 안함
        // students배열을 저장해 놓고 우리반,행발,과제,상담에서 탭 할때마다 fetchData 하는게 아니라
        // students 배열 미리 만들어 놓고 쓰기위해 (우리반 토글이 바뀌면 다시 students 배열 만듬)
        studentViewModelData.uuid = homeViewModelData.uribanID
        growthViewModelData.uuid = homeViewModelData.uribanID
        studentViewModelData.fetchData(uuid: homeViewModelData.uribanID)
    })
  }
}

private extension MainTabView {
    
    var home: some View {
      
      HomeView()
        .environmentObject(homeViewModelData)
        .environmentObject(studentViewModelData)
        .environmentObject(growthViewModelData)
        .tag(Tabs.home)
        .tabItem {
          Image(systemName: "house.fill")
          Text("홈")
         }
    }
    
  var myclass: some View {
    
//    UriBanView(uribanID: homeViewModelData.uribanID, uribanClassName: homeViewModelData.uribanClassName)
//    UriBanView(uribanID: homeViewModelData.uribanID, uribanClassName: homeViewModelData.uribanClassName)
    UriBanView()
        .environmentObject(homeViewModelData)
        .environmentObject(studentViewModelData)
        .tag(Tabs.myclass)
        .tabItem {
            Image(systemName: "person.2.fill")
            Text("우리반")
        }
  }
    
    var growth: some View {
        GrowthView()
            .environmentObject(studentViewModelData)
            .environmentObject(growthViewModelData)
            .environmentObject(homeViewModelData)
        .tag(Tabs.growth)
          .tabItem {
              Image(systemName: "rectangle.stack.person.crop.fill")
              Text("관찰")
          }
    }
  
  var subject: some View {
//    Text("과제")
    CountByMonthView(uribanID: homeViewModelData.uribanID, uribanClassName: homeViewModelData.uribanClassName)
        .environmentObject(growthViewModelData)
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

struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabView()
  }
}
