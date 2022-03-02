//
//  FriendsTableViewCell.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit
import Alamofire

protocol CellUpdater: AnyObject {
    func updateTableView()
}

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendImage: RoundedImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendOnlineStatus: UILabel!
    @IBOutlet weak var friendMenuButton: UIButton!
    
    var parentVC: UIViewController!
    weak var delegate: CellUpdater?

    func update() {
        delegate?.updateTableView()
    }
    
    func makeFriendMenu(_ friendItem: FriendItem) -> UIMenu {
        
        var actions = [UIAction]()
        
        actions.append(UIAction(title: "Удалить из друзей",
                                image: UIImage(systemName: "trash"),
                                attributes: .destructive,
                                handler: {_ in self.removeFromFriends(friendItem) }))
        
        return UIMenu(children: actions)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendMenuButton.showsMenuAsPrimaryAction = true
    }
    
    override func prepareForReuse() {
        friendImage.image = nil
    }
    
    func configure(_ friendItem: FriendItem) {
        
        friendMenuButton.menu = makeFriendMenu(friendItem)
        
        friendName.text = "\(friendItem.firstName) \(friendItem.lastName)"
        friendImage.image = UIImage(named: "placeholder")
        
        var friendFemale: Bool {
            switch friendItem.sex {
            case 2:
                return false
            case 1:
                return true
            default:
                return false
            }
        }
        
        if friendItem.online == 1 {
            friendOnlineStatus.text = "Онлайн"
            friendOnlineStatus.textColor = UIColor.systemGreen
        } else {
            friendOnlineStatus.text = friendFemale ? "Была " : "Был "
            friendOnlineStatus.text! += friendItem.lastSeen?.time.getRelativeDateStringFromUTC().lowercased() ?? ""
            friendOnlineStatus.textColor = UIColor.secondaryLabel
        }
        
        if let friendPhoto = friendItem.photo100 {
            friendImage.asyncLoadImageUsingCache(withUrl: friendPhoto)
        }
    }
    
    private func removeFromFriends(_ friendItem: FriendItem) {
        
        let alert = UIAlertController(title: "Удалить из друзей?", message: "\(friendItem.firstName) \(friendItem.lastName) будет удален из списка ваших друзей. Вы уверены?", preferredStyle: .alert)
        
        let successAlert = UIAlertController(title: "Удалить из друзей",
                                             message: "\(friendItem.firstName) \(friendItem.lastName) успешно удален из списка ваших друзей!",
                                             preferredStyle: .alert)
        
        successAlert.addAction(UIAlertAction(title: "Отлично!", style: .default, handler: nil))
        
        let errorAlert = UIAlertController(title: "Ошибка удаления",
                                             message: "Не удалось удалить \(friendItem.firstName) \(friendItem.lastName) из списка ваших друзей! Попробуйте позже.",
                                             preferredStyle: .alert)
        
        errorAlert.addAction(UIAlertAction(title: "Хорошо!", style: .default, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
            
            FriendAPI(Session.instance).removeFromFriends(friendItem.id){ [weak self] friendDelete in

                guard self != nil else { return }

                if friendDelete?.response.success == 1 {
                    self?.parentVC.present(successAlert, animated: true)
                    self?.update()
                } else {
                    self?.parentVC.present(errorAlert, animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        
        parentVC.present(alert, animated: true)
        
    }
}
