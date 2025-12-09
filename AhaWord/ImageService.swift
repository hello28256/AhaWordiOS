//  ImageService.swift
//  AhaWord

import Foundation

// 只关心 md5，其他字段可以不要，JSONDecoder 会自动忽略多余字段
struct BingMetaItem: Codable {
    let md5: String
}

final class ImageService {
    static let shared = ImageService()
    private init() {}

    // 对应 uni.cdnBase = "https://cdn.luckie.top"
    private let cdnBaseURL = URL(string: "https://cdn.luckie.top")!

    // MARK: - Bing 直搜图片

    /// 获取 Bing 图片 URL 列表（直搜）
    func fetchBingImageURLs(for word: String) async throws -> [URL] {
        // 1. 元信息地址: https://cdn.luckie.top/image-info/bing/{word}.json
        let metaURL = cdnBaseURL.appendingPathComponent("image-info/bing/\(word).json")
        print("=== fetchBingImageURLs ===")
        print("Request URL =", metaURL.absoluteString)

        // 2. 发请求
        let (data, response) = try await URLSession.shared.data(from: metaURL)

        // 3. 打印状态码（调试用，可留可删）
        if let http = response as? HTTPURLResponse {
            print("status code =", http.statusCode)
        }

        // 4. 解析 JSON：顶层是数组 [ { md5: "..." }, ... ]
        let items = try JSONDecoder().decode([BingMetaItem].self, from: data)

        // 5. 把 md5 映射成真正图片 URL:
        //    https://cdn.luckie.top/image/bing/{word}/{md5}.jpg
        let imageURLs = items.map { item in
            cdnBaseURL.appendingPathComponent("image/bing/\(word)/\(item.md5).jpg")
        }

        return imageURLs
    }

    // MARK: - Bing illustration 图片（如果你之后要用，可以按需要调用）

    /// 获取 Bing illustration 图片 URL 列表
    func fetchBingIllustrationURLs(for word: String) async throws -> [URL] {
        // 如果 bing-illustration 的 JSON 结构和刚才一样，逻辑也一样
        let metaURL = cdnBaseURL.appendingPathComponent("image-info/bing-illustration/\(word).json")
        print("=== fetchBingIllustrationURLs ===")
        print("Request URL =", metaURL.absoluteString)

        let (data, response) = try await URLSession.shared.data(from: metaURL)

        if let http = response as? HTTPURLResponse {
            print("status code =", http.statusCode)
        }

        let items = try JSONDecoder().decode([BingMetaItem].self, from: data)

        // 这里我假设图片路径是 image/bing-illustration/{word}/{md5}.jpg
        // 如果你 uni-app 里写的是别的路径，就按你的实际路径改这一行
        let imageURLs = items.map { item in
            cdnBaseURL.appendingPathComponent("image/bing-illustration/\(word)/\(item.md5).jpg")
        }

        return imageURLs
    }
}
