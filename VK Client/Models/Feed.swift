//
//  Feed.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

// MARK: - Feed
struct Feed: Codable {
    let response: FeedResponse
    
    init (response: FeedResponse) {
        self.response = response
    }
}

// MARK: - Response
struct FeedResponse: Codable {
    let items: [Item]
    let profiles: [Profile]
    let groups: [Group]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
    
    init(items: [Item], profiles: [Profile], groups: [Group], nextFrom: String) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
}

// MARK: - Group
struct Group: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct Item: Codable {
    let sourceID: Int
    let date: TimeInterval
    let canDoubtCategory, canSetCategory: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource
    let comments: Comments
    var likes: feedLikes
    let reposts: Reposts
    let views: Views?
    let postID: Int?
    let type: String
    
    // MARK: - Computed properties.
    
    var hasText: Bool {
        return self.text != nil && self.text != ""
    }
    
    var hasPhoto: Bool {
        return self.attachments?[0].photo?.photoAvailable != nil
    }
    
    var hasLink: Bool {
        return self.attachments?[0].link?.url != nil
    }
    
//    var attachedLinkIndex: Int? {
//        return self.attachments?.firstIndex(where: { $0.type == "link" })
//    }
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case postID = "post_id"
        case type
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: PhotoItem?
    let link: Link?
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let title: String?
    let photo: PhotoItem?
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let accessKey: String?
    let height: Int?
    let photo1280, photo130, photo604, photo75: String?
    let photo807: String?
    let postID: Int?
    let text: String
    let userID, width: Int?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case height
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case postID = "post_id"
        case text
        case userID = "user_id"
        case width
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Likes
struct feedLikes: Codable {
    var count, userLikes, canLike, canPublish: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let sex: Int
    let screenName: String?
    let photo50, photo100: String
    let onlineInfo: OnlineInfo
    let online: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool?
    
    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
