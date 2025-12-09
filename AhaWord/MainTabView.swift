//
//  MainTabView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//



import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house")
                }

            ListView()
                .tabItem {
                    Label("列表", systemImage: "list.bullet")
                }

            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person")
                }
        }
    }
}
