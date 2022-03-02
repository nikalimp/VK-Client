//
//  PhotoAPI.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import Alamofire

class PhotoAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/photos.getAll"
    
    var params: Parameters
    
    init(_ session: Session) {
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "count": 200,
            "v": session.version,
        ]
        
    }
    
    func get(_ completion: @escaping (Photos?) -> ()) {
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var photos: Photos
                photos = try JSONDecoder().decode(Photos.self, from: data)
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
