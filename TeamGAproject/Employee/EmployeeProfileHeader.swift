//
//  EmployeeProfileHeader.swift
//  TeamGAproject
//
//  Created by sowah on 4/6/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class EmployeeProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            
            //fetch image for profile
            guard let profileImageUrl = user?.profileImageUrl else { return }
            guard let url = URL(string: profileImageUrl) else { return }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
                guard let data = data else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }).resume()
            
            //fetch user name and position
            nameLabel.text = user?.username
            positionLabel.text = user?.position
            //fetch user phone number, email, and office number
            setupAttributeCaption()
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "team-placeholder")
        return iv
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 17)
        return name
    }()
    
    let positionLabel: UILabel = {
        let position = UILabel()
        position.textColor = .lightGray
        return position
    }()
    
    let phoneNumberLabel: UILabel = {
        let phone = UILabel()
        
        
        phone.numberOfLines = 0
        phone.textAlignment = .left
        return phone
    }()
    
    let emailLabel: UILabel = {
        let email = UILabel()
        email.numberOfLines = 0
        email.textAlignment = .left
        return email
    }()
    
    let officeLabel: UILabel = {
        let office = UILabel()
        office.numberOfLines = 0
        office.textAlignment = .left
        return office
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setup auto layout
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, padddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 126, height: 126)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = 126/2
        profileImageView.clipsToBounds = true
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(positionLabel)
        positionLabel.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        positionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(phoneNumberLabel)
        phoneNumberLabel.anchor(top: positionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(emailLabel)
        emailLabel.anchor(top: phoneNumberLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(officeLabel)
        officeLabel.anchor(top: emailLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //fetch user phone number, email, and office number
    fileprivate func setupAttributeCaption() {
        guard let user = self.user else { return }
        
        let phoneAttributedText = NSMutableAttributedString(string: "Phone\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        phoneAttributedText.append(NSMutableAttributedString(string: user.phone, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]))
        phoneNumberLabel.attributedText = phoneAttributedText
        
        let emailAttributedText = NSMutableAttributedString(string: "Email\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        emailAttributedText.append(NSMutableAttributedString(string: user.email, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]))
        emailLabel.attributedText = emailAttributedText
        
        let officeAttributedText = NSMutableAttributedString(string: "Office\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        officeAttributedText.append(NSMutableAttributedString(string: user.office, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]))
        officeLabel.attributedText = officeAttributedText
    }
}
