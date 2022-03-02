//
//  GroupTableViewCellNoDesc.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit
import Alamofire

class GroupTableViewCellNoDesc: UITableViewCell {
    
        @IBOutlet weak var groupImage: RoundedImageView!
        @IBOutlet weak var groupName: UILabel!
        @IBOutlet weak var membersCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        groupImage.image = nil
    }
    
    func configure(_ groupItem: GroupItem) {
        
        groupName.text = groupItem.name
        groupImage.image = UIImage(named: "placeholder")
        
        membersCount.text =  "\(groupItem.membersCount.formatted) подписчиков"
        
        groupImage.asyncLoadImageUsingCache(withUrl: groupItem.imageURL)
    }
}
