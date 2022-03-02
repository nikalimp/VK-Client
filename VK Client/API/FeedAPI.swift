//
//  FeedAPI.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

import Foundation
import Alamofire
import SwiftyJSON

class FeedAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/newsfeed.get"
    
    var params: Parameters
    
    init() {
        
        let session = Session.instance
        
        self.params = [
            "client_id": session.cliendId,
            "user_id": session.userId,
            "access_token": session.token,
            "v": session.version,
            "filters": "post",
            "count": "50",
        ]
        
    }
    
    func get(startTime: TimeInterval? = nil, startFrom: String? = nil, _ completion: @escaping (Feed?) -> ()) {
        
        let url = baseUrl + method
        
        if startTime != nil {
            self.params["start_time"] = startTime
        }
        
        if startFrom != nil {
            self.params["start_from"] = startFrom
        }
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            //print(response.request!)
            
            guard let data = response.data else { return }
            
            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatchGroup = DispatchGroup()
            
            let vkItemsJSONArr = json["response"]["items"].arrayValue
            let vkProfilesJSONArr = json["response"]["profiles"].arrayValue
            let vkGroupsJSONArr = json["response"]["groups"].arrayValue
            let nextFrom = json["response"]["next_from"].stringValue
            
            var vkItemsArray: [Item] = []
            var vkProfilesArray: [Profile] = []
            var vkGroupsArray: [Group] = []
            
            // decoding items
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, items) in vkItemsJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Item.self, from: items.rawData())
                        vkItemsArray.append(decodedItem)
                        
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                //print("items")
            }

            
            // decoding profiles
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in vkProfilesJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Profile.self, from: profiles.rawData())
                        vkProfilesArray.append(decodedItem)
                        
                    } catch(let errorDecode) {
                        print("Profile decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                //print("profiles")
            }
            
            // decoding groups
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in vkGroupsJSONArr.enumerated() {
                    do {
                        let decodedItem = try decoder.decode(Group.self, from: groups.rawData())
                        vkGroupsArray.append(decodedItem)
                        
                    } catch(let errorDecode) {
                        print("Group decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                //print("groups")
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                let response = FeedResponse(items: vkItemsArray,
                                            profiles: vkProfilesArray,
                                            groups: vkGroupsArray,
                                            nextFrom: nextFrom)
                let feed = Feed(response: response)
                
                completion(feed)
            }
        }
    }
}
