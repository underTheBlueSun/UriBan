//
//  MainTabView.swift
//  UriBan
//
//  Created by underTheBlueSun on 2021/01/18.
//  Copyright © 2021 underTheBlueSun. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
        // 탭바 배경 색깔 변경. 2021.1월 iOS 14.3 버그로 추정
//        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.tertiaryLabel
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
  private enum Tabs {
    case home, myclass, subject, counsel, paper
  }
  
  @State private var selectedTab: Tabs = .home
  
  var body: some View {

    TabView(selection: $selectedTab) {
        
      Group {
        home
        myclass
        subject
        counsel
        paper
      }
      
    }
    .accentColor(.systemTeal)
    .edgesIgnoringSafeArea(.top)
  }
}

private extension MainTabView {
    
    var home: some View {
      
      HomeView()
        .tag(Tabs.home)
        .tabItem {
          Image(systemName: "house.fill")
          Text("홈")
         }
    }
    
    
  var myclass: some View {
    
    Text("우리반")
      .tag(Tabs.myclass)
      .tabItem {
        Image(systemName: "person.2.fill")
        Text("우리반")
       }
  }
  
  var subject: some View {
    Text("과제")
      .tag(Tabs.subject)
        .tabItem {
            Image(systemName: "square.and.pencil")
            Text("과제")
        }
  }
  
  var counsel: some View {
    Text("상담")
      .tag(Tabs.counsel)
        .tabItem {
            Image(systemName: "ear")
            Text("상담")
        }
  }
    
    var paper: some View {
      Text("안내장")
        .tag(Tabs.paper)
        .tabItem {
            Image(systemName: "doc.text.fill")
            Text("안내장")
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
