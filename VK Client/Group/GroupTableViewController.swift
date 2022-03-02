//
//  GroupTableViewController.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var groupItems: [GroupItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        let opq = OperationQueue()
        
        let fetchGroupData = FetchGroupData()
        opq.addOperation(fetchGroupData)
        
        let parseGroupData = ParseGroupData()
        parseGroupData.addDependency(fetchGroupData)
        opq.addOperation(parseGroupData)
        
        let displayGroupData = DisplayGroupData(self)
        displayGroupData.addDependency(parseGroupData)
        OperationQueue.main.addOperation(displayGroupData)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if groupItems[indexPath.row].groupDescription == "" {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCellNoDesc") as? GroupTableViewCellNoDesc
            else { return UITableViewCell() }
            
            cell.configure(groupItems[indexPath.row])
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupTableViewCell
            else { return UITableViewCell() }
            
            cell.configure(groupItems[indexPath.row])
            return cell
            
        }
    }
}
