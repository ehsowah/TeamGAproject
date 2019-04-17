//
//  EmployeeProfileController.swift
//  TeamGAproject
//
//  Created by sowah on 4/6/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class EmployeeProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView.backgroundColor = .white
        collectionView.register(EmployeeProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        fetchUser()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! EmployeeProfileHeader
        header.backgroundColor = .white
        header.user = user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    var user: User?
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let selectUser = userId else { return }
        
        Database.database().reference().child("users").child(selectUser).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(uid: uid, dictionary: dictionary)
            self.collectionView.reloadData()
            
        }) { (err) in
            print("failed to fetch user:", err)
        }
    }
    
    
}
