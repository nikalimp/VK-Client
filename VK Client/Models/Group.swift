//
//  Group.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

// MARK: - Main
struct Groups: Codable {
    let response: GroupResponse
}

// MARK: - Response
struct GroupResponse: Codable {
    let count: Int
    let items: [GroupItem]
}

// MARK: - Item
class GroupItem: Codable {
    var id: Int = 0
    var name: String = ""
    var groupDescription: String?
    var imageURL: String = ""
    var membersCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case id, name
        case groupDescription = "description"
        case imageURL = "photo_100"
        case membersCount = "members_count"
    }
}
