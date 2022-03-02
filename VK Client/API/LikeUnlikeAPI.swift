//
//  LikeUnlikeAPI.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import Alamofire

class LikeUnlikeAPI {
    
    let baseUrl = "https://api.vk.com/method"
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
        ]
        
    }
    
    func likeItem(type: VKItemType, itemID: Int, ownerID: Int, _ completion: @escaping (Likes?) -> ()) {
        
        let method = "/likes.add"
        let url = baseUrl + method
        
        params["item_id"] = itemID
        params["owner_id"] = ownerID
        params["type"] = "post"
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var likes: Likes
                likes = try JSONDecoder().decode(Likes.self, from: data)
                completion(likes)
            } catch {
                print(error)
            }
            
        }
    }
    
    func unLikeItem(type: VKItemType, itemID: Int, ownerID: Int, _ completion: @escaping (Likes?) -> ()) {
        
        let method = "/likes.delete"
        let url = baseUrl + method
        
        params["item_id"] = itemID
        params["owner_id"] = ownerID
        params["type"] = "post"
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var likes: Likes
                likes = try JSONDecoder().decode(Likes.self, from: data)
                completion(likes)
            } catch {
                print(error)
            }
            
        }
    }
}
