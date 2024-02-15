//
//  AboutHotel.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation

// MARK: - Hotel

// Structure representing hotel data
struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel

    // Enum to set decoding keys to convert some snake_case constants to camelCase format
    enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
    
    static var shared = Hotel(id: Int(), name: String(), adress: String(), minimalPrice: Int(), priceForIt: String(), rating: Int(), ratingName: String(), imageUrls: [String](), aboutTheHotel: AboutTheHotel(description: String(), peculiarities: [String]()))
}

// MARK: - AboutTheHotel

// Structure for storing detailed hotel information
struct AboutTheHotel: Codable {
    let description: String
    let peculiarities: [String]
}
