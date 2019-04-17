//
//  NewsFeedCell.swift
//  TeamGAproject
//
//  Created by sowah on 3/25/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            guard let profileImageUrl = post?.profileImageUrl else { return }
            nameLabel.text = post?.username
            dateLabel.text = post?.creationDate.timeAgoDisplay()
            textLable.text = post?.caption
            positionLable.text = post?.position
            userProfileImageView.loadImage(urlString: profileImageUrl)
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = #imageLiteral(resourceName: "team-placeholder")
        imageView.layer.cornerRadius = 42/2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Eh So Wah"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let positionLable: UILabel = {
        let label = UILabel()
        label.text = "App Developer"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    let textLable: UITextView = {
        let textView = UITextView()
        textView.text = "I think both these pices of advice go hand in hand. Dream big if you’re prepared to work hard!"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userProfileImageView)
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 42, height: 42)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, padddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, padddingTop: 16, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(positionLable)
        positionLable.anchor(top: nameLabel.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: nil, padddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(textLable)
        textLable.anchor(top: positionLable.bottomAnchor, left: positionLable.leftAnchor, bottom: bottomAnchor, right: rightAnchor, padddingTop: 5, paddingLeft: -5, paddingBottom: 5, paddingRight: 16, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
