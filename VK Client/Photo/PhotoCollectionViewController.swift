//
//  PhotoCollectionViewController.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import ImageViewer_swift

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoItems: [PhotoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoAPI(Session.instance).get{ [weak self] photos in
            guard let self = self else { return }
            self.photoItems = photos!.response.items!
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
       
        cell.photoView.asyncLoadImageUsingCache(withUrl: photoItems[indexPath.row].photoAvailable!.url,
                                                withImageViewer: true,
                                                indicator: cell.photoIndicator)
        
        return cell
    }
}
