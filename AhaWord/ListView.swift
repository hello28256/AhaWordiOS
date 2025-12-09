//
//  ListView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import SwiftUI

struct ListView: View {
    @State private var items: [Item] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("加载中…")
                } else if let errorMessage = errorMessage {
                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                        Button("重试") {
                            Task { await loadData() }
                        }
                    }
                } else {
                    if items.isEmpty {
                        VStack(spacing: 12) {
                            Text("暂无数据")
                                .foregroundStyle(.secondary)
                            Button("刷新") {
                                Task { await loadData() }
                            }
                        }
                    } else {
                        List(items) { item in
                            NavigationLink {
                                DetailView(item: item)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.desc)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                }
            }
            .navigationTitle("列表")
            .toolbar {
                Button {
                    Task { await loadData() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .task {
                // 页面首次出现时加载
                await loadData()
            }
        }
    }

    private func loadData() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let fetched = try await APIService.shared.fetchItems()
            // 回到主线程更新UI（async/await 下这里已经是主线程，一般没问题）
            items = fetched
        } catch {
            errorMessage = "加载失败：\(error.localizedDescription)"
        }
    }
}
