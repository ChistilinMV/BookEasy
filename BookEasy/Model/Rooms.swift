//
//  Rooms.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation

// MARK: - Rooms

// Structure representing number data
struct Rooms: Codable {
    let rooms: [Room]
    
    static var shared = Rooms(rooms: [Room]())
}

// MARK: - Room

// Structure for storing detailed information about numbers
struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]

    // Enum to set decoding keys to convert some snake_case constants to camelCase format
    enum CodingKeys: String, CodingKey {
        case id, name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
