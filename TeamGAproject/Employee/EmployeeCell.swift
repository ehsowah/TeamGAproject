//
//  EmployeeCell.swift
//  TeamGAproject
//
//  Created by sowah on 4/6/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit

class EmployeeCell: UICollectionViewCell {
    
    var users: Post? {
        didSet {
            guard let imageUrl = users?.profileImageUrl else { return }
            userProfileImage.loadImage(urlString: imageUrl)
            userName.text = users?.username
        }
    }
    
    let userProfileImage: CustomImageView = {
        let image = CustomImageView()
        image.image = #imageLiteral(resourceName: "team-placeholder")
        return image
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(userProfileImage)
        userProfileImage.anchor(top: nil, left: nil, bottom: nil, right: nil, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 126, height: 126)
        userProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userProfileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userProfileImage.layer.cornerRadius = 126 / 2
        userProfileImage.layer.masksToBounds = true
        
        addSubview(userName)
        userName.anchor(top: userProfileImage.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        userName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
