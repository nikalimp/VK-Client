//
//  PhotoCollectionViewCell.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        photoView.image = nil
    }
}
