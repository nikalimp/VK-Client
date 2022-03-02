//
//  FeedItemPhotoTableViewCell.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit

class FeedItemPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedItemPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        feedItemPhoto.image = nil
    }
    
    func configure(url: String? = nil) {
        
        guard let url = url else { return }
        feedItemPhoto.asyncLoadImageUsingCache(withUrl: url, withImageViewer: false)
    }
}
