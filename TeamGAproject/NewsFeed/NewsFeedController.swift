//
//  NewsFeedController.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class NewsFeedController: UITableViewController {
  
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: ComposeView.updateFeedNotificationName, object: nil)
        
        title = "News Feed"
        tableView.backgroundColor = .white
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        setupAddNewsFeedButton()
        fetchPost()
    }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPost()
    }

    var posts = [Post]()
    func fetchPost() {
        Database.database().reference().child("posts").observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            dictionary.forEach({ (key, value) in
                guard let postDictionary = value as? [String: Any] else { return }
                guard let theKey = key as? String else { return }
                
                self.posts.append(Post(key: theKey, dictionary: postDictionary))
                self.posts.sort(by: { (p1, p2) -> Bool in
                    return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                })
                
            })
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    fileprivate func setupAddNewsFeedButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(handleAddButton))
    }
    
    @objc func handleAddButton() {
        let composeView = UINavigationController(rootViewController: ComposeView())
        present(composeView, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsFeedCell
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        cell.post = posts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            
            Database.database().reference().child("posts").child(posts[indexPath.row].key).removeValue { (error, ref) in
                if error != nil {
                    return
                }
                self.posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            
        }
    }
   
}
