//
//  MainTabBarController.swift
//  TeamGAproject
//
//  Created by sowah on 3/21/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            let loginController = LoginController()
            let navController = UINavigationController(rootViewController: loginController)
            DispatchQueue.main.async {
                self.present(navController, animated: true, completion: nil)
            }

            return
        }
        
        setUpViewController()
    }
    
    func setUpViewController() {
        //timer
        let timerNavController = templateNavController(tabTitle: "Clock In/Out", unselectedImage: #imageLiteral(resourceName: "time"), selectedImage: #imageLiteral(resourceName: "timeSelected"), rootViewController: TimerController())
        
        //newsfeed
        let newsFeedNavController = templateNavController(tabTitle: "News Feed", unselectedImage: #imageLiteral(resourceName: "post"), selectedImage: #imageLiteral(resourceName: "postSelected"), rootViewController: NewsFeedController())
        
        //team
        let teamNavController = templateNavController(tabTitle: "Home", unselectedImage: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "homeSelected"), rootViewController: HomeViewController())
        
        //profile
        let profileNavController = templateNavController(tabTitle: "Profile", unselectedImage: #imageLiteral(resourceName: "profile"), selectedImage: #imageLiteral(resourceName: "profileSelected"), rootViewController: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //employee
        let employeeNavController = templateNavController(tabTitle: "Employees", unselectedImage: #imageLiteral(resourceName: "team"), selectedImage: #imageLiteral(resourceName: "teamSelected-1"), rootViewController: EmployeeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        tabBar.tintColor = .black
        
        viewControllers = [teamNavController, newsFeedNavController, timerNavController, profileNavController, employeeNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(tabTitle: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.title = tabTitle
        return navController
    }
}
