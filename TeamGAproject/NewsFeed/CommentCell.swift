//
//  CommentCell.swift
//  TeamGAproject
//
//  Created by sowah on 3/28/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else { return }
            
            //            guard let profileImageUrl = comment.user?.profileImageUrl else { return }
            //
            //            guard let username = comment.user?.username else { return }
            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            
            //            textLabel.text = comment.text
            
            attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            textLabel.attributedText = attributedText
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }
    
    let textLabel: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 14)
        //        label.numberOfLines = 0
        textview.isScrollEnabled = false
        return textview
    }()
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(textLabel)
        textLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, padddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
