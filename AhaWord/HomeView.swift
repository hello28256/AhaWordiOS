//
//  HomeView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("首页")
                    .font(.largeTitle)
                    .bold()

                Text("这里可以放你小程序首页的内容，比如 Banner、功能入口等。")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("首页")
        }
    }
}
