//
//  LikeButton.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import Foundation
import UIKit

class LikeButton: UIButton {
    
    var likesCount = 0
    var isLikedByMe = false
    var itemID = 0
    var ownerID = 0
    var handlerLiked: () -> Void = {}
    var handlerUnLiked: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addActions()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 15, height: 30)
    }
    
    func configure(likesCount: Int,
                   isLikedByMe: Bool,
                   itemID: Int,
                   ownerID: Int,
                   completionHandlerLiked: @escaping () -> Void,
                   completionHandlerUnLiked: @escaping () -> Void) {
        
        self.likesCount = likesCount
        self.isLikedByMe = isLikedByMe
        self.itemID = itemID
        self.ownerID = ownerID
        self.handlerLiked = completionHandlerLiked
        self.handlerUnLiked = completionHandlerUnLiked
        
        self.contentHorizontalAlignment = .leading
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        setTitleDependingOnState()
        
    }
    
    private func addActions() {
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    private func setTitleDependingOnState() {
        
        self.setTitleColor(isLikedByMe ?  UIColor.systemPink : UIColor.secondaryLabel, for: .normal)
        self.setTitle("\(isLikedByMe ? "♥" : "♡") \(likesCount.formatted)", for: .normal)
    }
    
    @objc func onTap(_ sender: UIButton) {
        
        isLikedByMe.toggle()
        likesCount += isLikedByMe ? 1 : -1
        self.setTitleDependingOnState()
        
        if isLikedByMe {
            
            // like item
            
            LikeUnlikeAPI(Session.instance).likeItem(type: VKItemType.post,
                                                     itemID: itemID,
                                                     ownerID: ownerID) {
                [weak self] likes in
                guard let _ = self
                else {
                    
                    self?.isLikedByMe = false
                    self?.likesCount -= 1
                    return
                }
                
                self?.handlerLiked()
                
            }
        } else {
            
            //unlike item
            
            LikeUnlikeAPI(Session.instance).unLikeItem(type: VKItemType.post,
                                                       itemID: itemID,
                                                       ownerID: ownerID) {
                [weak self] likes in
                guard let _ = self
                else {
                    
                    self?.isLikedByMe = true
                    self?.likesCount += 1
                    return
                }
                
                self?.handlerUnLiked()
                
            }
        }
    }
}
