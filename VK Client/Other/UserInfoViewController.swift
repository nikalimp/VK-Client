//
//  UserInfoViewController.swift
//  VK Client
//
//  Created by Никита Алимпиев on 23.02.2022.
//

import UIKit
import PromiseKit
import Alamofire
import AlamofireImage

class UserInfoViewController: UIViewController {

    @IBOutlet weak var userImage: RoundedImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pinIcon: UIImageView!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promiseFetchUserData().then { [self] user in
            
            promiseFetchUserPicture(user).map{ ($0, user) }
            
        }.done { [self] image, user in
            
            displayUserInfo(user: user, image: image)
            
        }.catch { error in
            
            print(error)
            
        }
    }
    
    // MARK: - Promise methods.
    
    func promiseFetchUserData() -> Promise<User> {
        
        return Promise<User> { seal in
            
            UserAPI(Session.instance).get{ [weak self] user in
                
                guard self == self else {
                    seal.reject(UserAPI.Errors.unknownError)
                    return
                }
                seal.fulfill(user!)
            }
        }
    }
    
    func promiseFetchUserPicture(_ user: User) -> Promise<UIImage> {
        
        return Promise<UIImage> { seal in
            
            guard let imageUrl = user.response[0].photo200 else {
                seal.reject(UserAPI.Errors.noPhotoUrl)
                return
            }
            
            AF.request(imageUrl, method: .get).responseImage { response in
                
                guard let image = response.value else { return }
                seal.fulfill(image)
            }
        }
    }
    
    // MARK: - Private methods.
    
    private func displayUserInfo(user: User, image: UIImage) {
        
        userName.text = "\(user.response[0].firstName) \(user.response[0].lastName)"
        userLocation.text = "\(user.response[0].city.title), \(user.response[0].country.title)."
        userImage.image = image
        
        self.userImage.isHidden = false
        self.userName.isHidden = false
        self.pinIcon.isHidden = false
        self.userLocation.isHidden = false
        self.loadingIndicator.stopAnimating()
        
    }
}
