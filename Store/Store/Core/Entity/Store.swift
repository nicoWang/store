//
//  Store.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation

struct Store: Codable {
    var title: String?
    var sections: [Section]?
}

// MARK: - Section
struct Section: Codable {
    var title: String?
    var items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    var detailURL, imageURL: String?
    var brand, title, tags: String?
    var favoriteCount: Int?

    enum CodingKeys: String, CodingKey {
        case detailURL = "detailUrl"
        case imageURL = "imageUrl"
        case brand, title, tags, favoriteCount
    }
}
