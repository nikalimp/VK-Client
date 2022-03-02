//
//  User.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

struct User: Codable {
    let response: [UserResponse]
}

struct UserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let city, country: Location
    let photo200: String?
    let hasPhoto: Int

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case city, country
        case photo200 = "photo_200"
        case hasPhoto = "has_photo"
    }
}

struct Location: Codable {
    let id: Int
    let title: String
}
