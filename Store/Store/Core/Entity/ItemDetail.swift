//
//  ItemDetail.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import Foundation

// MARK: - ItemDetail
struct ItemDetail: Codable {
    var id: Int?
    var imageURL: String?
    var brand, title, tags: String?
    var favoriteCount: Double?
    var itemDetailDescription: String?
    var price: Price?
    var expiration, redemptionsCap: String?
    
    var favoriteCountFormatted: String {
        return favoriteCount?.kmFormatted ?? "0"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case brand, title, tags, favoriteCount
        case itemDetailDescription = "description"
        case price, expiration, redemptionsCap
    }
}

// MARK: - Price
struct Price: Codable {
    var old, new: String?
}
