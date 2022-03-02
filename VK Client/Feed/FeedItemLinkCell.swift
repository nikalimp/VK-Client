//
//  FeedItemLinkCell.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import UIKit
import ActiveLabel
import Alamofire

class FeedItemLinkCell: UITableViewCell {
    
    @IBOutlet weak var linkTitle: UILabel!
    @IBOutlet weak var linkURL: ActiveLabel!
    @IBOutlet weak var linkPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        linkPhoto.image = nil
    }
    
    func configure(link: Link) {
     
        linkTitle.text = link.title ?? "Без названия..."
        
        linkURL.customize { label in
            
            label.text = link.url
            
            label.enabledTypes = [.url]
            
            label.URLColor = activeURLColor
            label.URLSelectedColor = activeURLColorSelected
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
        }
        
        guard let linkPhotoUrl = link.photo?.photoAvailable?.url else { return }
        linkPhoto.asyncLoadImageUsingCache(withUrl: linkPhotoUrl)
    }
}
