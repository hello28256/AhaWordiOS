//
//  DetailView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(item.title)
                    .font(.title)
                    .bold()

                Text(item.desc)
                    .font(.body)
                    .foregroundStyle(.primary)

                // TODO: 这里可以根据你实际数据增加更多字段展示
                // 比如时间、标签、图片等
            }
            .padding()
        }
        .navigationTitle("详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}
