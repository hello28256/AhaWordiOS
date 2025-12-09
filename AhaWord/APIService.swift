//
//  APIService.swift
//  AhaWord
//
//  Created by yangq on 2025-12-09.
//

import Foundation

struct Item: Codable, Identifiable {
    let id: Int
    let title: String
    let desc: String
}

class APIService {
    static let shared = APIService()
    private init() {}

    private let baseURL = URL(string: "https://your-api.com")!

    func fetchItems() async throws -> [Item] {
        let url = baseURL.appendingPathComponent("/api/list")
        let (data, _) = try await URLSession.shared.data(from: url)
        let items = try JSONDecoder().decode([Item].self, from: data)
        return items
    }
}
