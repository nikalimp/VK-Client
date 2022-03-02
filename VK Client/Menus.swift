//
//  Menus.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import UIKit

// MARK: - Friend cell menu.

var friendsMenuItems: [UIAction]  = [
    UIAction(title: "Удалить нахрен из друзей", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in
        
//        let alert = UIAlertController(title: "Удалить из друзей",
//                                      message: "Вы действительно хотите удалить нахрен из друзей?",
//                                      preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
//
//        alert.present(alert, animated: true)
        
        print("hello \(100)")
        
    }),
]

let friendsMenu = UIMenu(children: friendsMenuItems)
