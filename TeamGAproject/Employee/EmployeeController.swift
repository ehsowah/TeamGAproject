//
//  EmployeeController.swift
//  TeamGAproject
//
//  Created by sowah on 4/6/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class EmployeeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let emCellId = "emCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employees Info"
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = #colorLiteral(red: 0.937036097, green: 0.9411780238, blue: 0.945192039, alpha: 1)
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: emCellId)
        fetchEmployee()
    }
    
    var users = [Post]()
    func fetchEmployee() {
        
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            dictionary.forEach({ (key, value) in
                print(value)
                guard let userInfoDictionary = value as? [String: Any] else { return }
                guard let userKey = key as? String else { return }
                
                self.users.append(Post(key: userKey, dictionary: userInfoDictionary))
                self.collectionView.reloadData()
            })
            
        }) { (err) in
            print("fail to fetch", err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userProfileController = EmployeeProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileController.userId = users[indexPath.item].key
        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emCellId, for: indexPath) as! EmployeeCell
        cell.users = users[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 2
        return CGSize(width: width, height: width)
    }
    
}
