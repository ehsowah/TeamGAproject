//
//  ComposeView.swift
//  TeamGAproject
//
//  Created by sowah on 3/26/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class ComposeView: UIViewController, UITextViewDelegate {
    
    var userName = String()
    var position = String()
    var profileImageUrl = String()
    
    let userProfile: CustomImageView = {
        let userProfile = CustomImageView()
        userProfile.image = #imageLiteral(resourceName: "team-placeholder")
        userProfile.layer.cornerRadius = 35/2
        userProfile.layer.masksToBounds = true
        return userProfile
    }()
    
    let textView: UITextView = {
       let textView = UITextView()
        textView.text = "What's happen?"
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .lightGray
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationButtons()
        textView.delegate = self
        
        view.addSubview(userProfile)
        userProfile.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        
        view.addSubview(textView)
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: userProfile.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        fetchUser()
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(handlePost))
    }
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    @objc func handlePost() {
        guard let textView = textView.text else { return }
        
        let userPostRef = Database.database().reference().child("posts")
        let ref = userPostRef.childByAutoId()
        
        let values = ["username": userName, "position": position, "caption": textView, "profileImageUrl": profileImageUrl, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                ProgressHUD.showError("fail to post", interaction: false)
                print("failed to save to DB", err)
                return
            }
            
            ProgressHUD.showSuccess("success", interaction: false)
            print("Successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: ComposeView.updateFeedNotificationName, object: nil)
        }
    }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.userName = dictionary["username"] as! String
            self.position = dictionary["position"] as! String
            self.profileImageUrl = dictionary["profileImageUrl"] as! String
            self.userProfile.loadImage(urlString: self.profileImageUrl)
            self.reloadInputViews()
        }) { (err) in
            print("failed to fetch user:", err)
        }
    }}
