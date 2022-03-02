//
//  UserAPI.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import Alamofire

class UserAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/users.get"
    
    enum Errors: Error {
        case unknownError
        case noPhotoUrl
    }
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "fields": "has_photo, photo_200, city, country",
        ]
        
    }
    
    func get(_ completion: @escaping (User?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var user: User
                user = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
            }
        }
    }
}
