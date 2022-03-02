//
//  Likes.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

// MARK: - Likes
struct Likes: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let likes: Int
}
