//
//  ProfileView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("关于") {
                    Text("词小悟 iOS 版")
                    Text("可以在这里放一些说明文字，比如：功能介绍、作者、仓库地址等。")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    // 如果想显示版本号：
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                       let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text("版本：\(version) (\(build))")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("我的")
        }
    }
}
