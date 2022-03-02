//
//  GroupAPIOperation.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation

class FetchGroupData: Operation {

    var data: Data?
    
    override func main() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/groups.get"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Session.instance.cliendId),
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "access_token", value: String(Session.instance.token)),
            URLQueryItem(name: "v", value: Session.instance.version),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description,members_count"),
        ]
        
        guard let url = components.url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        self.data = data
    }
}

class ParseGroupData: Operation {
    
    var groupItems: [GroupItem]? = []
    
    override func main() {
        guard let fetchGroupData = dependencies.first as? FetchGroupData,
              let data = fetchGroupData.data else { return }
        do {
            var groups: Groups
            groups = try JSONDecoder().decode(Groups.self, from: data)
            self.groupItems = groups.response.items
        } catch {
            print(error)
        }
    }
}

class DisplayGroupData: Operation {
    
    var controller: GroupTableViewController
    
    override func main() {
        guard let parseGroupData = dependencies.first as? ParseGroupData,
              let groupItems = parseGroupData.groupItems else { return }
        controller.groupItems = groupItems
        controller.tableView.reloadData()
        
    }
    
    init(_ controller: GroupTableViewController) {
        
        self.controller = controller
    }
}
