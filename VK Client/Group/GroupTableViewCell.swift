//
//  GroupTableViewCell.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit
import Alamofire

class GroupTableViewCell: UITableViewCell {
    
        @IBOutlet weak var groupImage: RoundedImageView!
        @IBOutlet weak var groupName: UILabel!
        @IBOutlet weak var groupDescription: UILabel!
        @IBOutlet weak var groupMemebersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        groupImage.image = nil
    }
    
    func configure(_ groupItem: GroupItem) {
        
        groupName.text = groupItem.name
        groupImage.image = UIImage(named: "placeholder")
        
        if let description = groupItem.groupDescription {
            groupDescription.text = description
        }
        
        groupMemebersCount.text =  "\(groupItem.membersCount.formatted) подписчиков"
        
        groupImage.asyncLoadImageUsingCache(withUrl: groupItem.imageURL)
    }
}
