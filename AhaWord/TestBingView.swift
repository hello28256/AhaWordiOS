//
//  TestBingView.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import SwiftUI

struct TestBingView: View {
    @State private var query: String = ""          // 用户输入的单词
    @State private var imageURLs: [URL] = []       // 图片地址列表
    @State private var isLoading = false           // 是否加载中
    @State private var errorMessage: String?       // 错误信息

    var body: some View {
        NavigationStack {
            VStack {
                // 输入区域
                HStack {
                    TextField("输入单词，例如 apple", text: $query)
                        .textInputAutocapitalization(.never)   // 不自动大写
                        .disableAutocorrection(true)          // 关闭自动纠错
                        .textFieldStyle(.roundedBorder)

                    Button("搜索") {
                        search()
                    }
                    .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)
                }
                .padding()

                // 内容区域
                ScrollView {
                    if isLoading {
                        ProgressView("加载中…")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    } else if imageURLs.isEmpty {
                        Text("请输入单词并点击「搜索」")
                            .foregroundStyle(.secondary)
                            .padding()
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                            ForEach(imageURLs, id: \.self) { url in
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Bing 图片")
        }
    }

    // MARK: - Actions

    private func search() {
        let word = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !word.isEmpty else {
            errorMessage = "请输入单词"
            imageURLs = []
            return
        }

        errorMessage = nil
        imageURLs = []
        isLoading = true

        Task {
            do {
                let urls = try await ImageService.shared.fetchBingImageURLs(for: word)
                imageURLs = urls
            } catch {
                errorMessage = "加载失败：\(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
