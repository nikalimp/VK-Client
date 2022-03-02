//
//  Friend.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

// MARK: - Friend
struct Friends: Codable {
    let response: FriendResponse
}

// MARK: - Response
struct FriendResponse: Codable {
    let count: Int
    let items: [FriendItem]
}

// MARK: - Item
struct FriendItem: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo100: String?
    let online: Int?
    let sex: Int?
    let lastSeen: LastSeen?
    let trackCode: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo100 = "photo_100"
        case online, sex
        case lastSeen = "last_seen"
        case trackCode = "track_code"
    }
}

// MARK: - LastSeen
struct LastSeen: Codable {
    let platform: Int?
    let time: TimeInterval
}

struct FriendDelete: Codable {
    let response: FriendDeleteResponse
}

struct FriendDeleteResponse: Codable {
    let success: Int
    let friendDeleted: Int?
    let outRequestDeleted: Int?
    let inRequestDeleted: Int?
    let suggestionDeleted: Int?
    
    enum CodingKeys: String, CodingKey {
        case success
        case friendDeleted = "friend_deleted"
        case outRequestDeleted = "out_request_deleted"
        case inRequestDeleted = "in_request_deleted"
        case suggestionDeleted = "suggestion_deleted"
    }
}
