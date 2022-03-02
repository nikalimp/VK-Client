//
//  Photo.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

// MARK: - Feed

struct Photos: Codable {
    let response: PhotoResponse
}

// MARK: - Response

struct PhotoResponse: Codable {
    let count: Int
    let items: [PhotoItem]?
}

// MARK: - Item

struct PhotoItem: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [Size]?
    let text: String?
    let lat, long: Double?
    let postID: Int?
    
    var photoAvailable: Size? {
        
        guard let sizes = self.sizes else { return nil }
        if let photo = sizes.first(where: {$0.type == "x"}) { return photo }
        if let photo = sizes.first(where: {$0.type == "z"}) { return photo }
        if let photo = sizes.first(where: {$0.type == "y"}) { return photo }
        if let photo = sizes.first(where: {$0.type == "m"}) { return photo }
        if let photo = sizes.first(where: {$0.type == "s"}) { return photo }
        
        return sizes.first
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text, lat, long
        case postID = "post_id"
    }
}
