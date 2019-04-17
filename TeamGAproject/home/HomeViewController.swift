//
//  TeamController.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let heroImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "heroImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to University Community District"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let title1: UILabel = {
        let label = UILabel()
        label.text = "Take the Next Step"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    let title1body: UILabel = {
        let label = UILabel()
        label.text = "Wherever you want to go next, we are here to provide you with options. Whether you are interested in university transfer, the medical field, career and technical education or an expansion of your workforce training, we are here to unleash your potential."
        label.font = .systemFont(ofSize: 19)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    let readMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("READ MORE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleReadMore), for: .touchUpInside)
        return button
    }()
    
    @objc func handleReadMore() {
        print("read more...")
    }
    
    let newsTitle: UILabel = {
       let label = UILabel()
       label.text = "News"
        label.font = .boldSystemFont(ofSize: 23)
        label.textColor = .black
       return label
    }()
    
    let news1date: UILabel = {
        let label = UILabel()
        label.text = "Mar 26, 2019"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    let news1body: UILabel = {
        let label = UILabel()
        label.text = "Craven CC registering for Summer Camps"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let news2date: UILabel = {
        let label = UILabel()
        label.text = "Feb 15, 2019"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    let news2body: UILabel = {
        let label = UILabel()
        label.text = "Craven CC’s Phi Theta Kappa students bring home 17 awards from convention"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let news3date: UILabel = {
        let label = UILabel()
        label.text = "Jan 04, 2019"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    let news3body: UILabel = {
        let label = UILabel()
        label.text = "Craven CC Physical Therapist Assistant Program accepting applications"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let viewAllNews: UILabel = {
        let label = UILabel()
        label.text = "View all news"
        label.textColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let videoTitle: UILabel = {
        let label = UILabel()
        label.text = "Spring Open House"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    let videoDate: UILabel = {
        let label = UILabel()
        label.text = "Jan 04, 2019"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    let videoThumbnail: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "picForVideo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let videoPlayButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handlePlayButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlayButton() {
        if let path = Bundle.main.path(forResource: "Spring Open House March 12, 2019", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
    
    let videoTextbody: UILabel = {
        let label = UILabel()
        label.text = "Craven Community College (Craven CC) will host a Spring Open House for new students Tuesday, March 12 from 5:30 to 7:30 p.m. at the Student Center on the New Bern Campus. The open house will have information relevant to all types of students, ranging from those embarking on a college journey or looking to take the next step in their career."
        label.font = .systemFont(ofSize: 19)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    let footerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.290160656, green: 0.2902164459, blue: 0.2901571095, alpha: 1)
        return view
    }()
    
    let footerSchool: UILabel = {
        let label = UILabel()
        label.text = "University Community District"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .lightGray
        return label
    }()
    
    let footerAddress: UILabel = {
        let label = UILabel()
        label.text = "150 E. 10th Street\nNorth Pittsburg, PA 91711\n909-621-8000"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 19)
        label.textColor = .lightGray
        return label
    }()
    
    let footerFollowUs: UILabel = {
        let label = UILabel()
        label.text = "Follow Us"
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .lightGray
        return label
    }()
    
    let footerStack: UIStackView = {
        
        let facebook = UIImageView()
        facebook.image = #imageLiteral(resourceName: "002-facebook-logo")
        facebook.contentMode = .scaleAspectFit
        
        let instagram = UIImageView()
        instagram.image = #imageLiteral(resourceName: "001-logo")
        instagram.contentMode = .scaleAspectFit
        
        let linkIn = UIImageView()
        linkIn.image = #imageLiteral(resourceName: "004-linkedin")
        linkIn.contentMode = .scaleAspectFit
        
        let twitter = UIImageView()
        twitter.image = #imageLiteral(resourceName: "003-twitter-logo-silhouette")
        twitter.contentMode = .scaleAspectFit
        
        let youtube = UIImageView()
        youtube.image = #imageLiteral(resourceName: "005-youtube")
        youtube.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [facebook, instagram, linkIn, twitter, youtube])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        
        return stack
    }()
    
    let footerCopyRight: UILabel = {
        let label = UILabel()
        label.text = "©2019 University Community District"
        label.font = .systemFont(ofSize: 19)
        label.textColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: view.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2000)
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        containerView.addSubview(heroImage)
        heroImage.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 525)
        
        containerView.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 40, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(title1)
        title1.anchor(top: heroImage.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(title1body)
        title1body.anchor(top: title1.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 112)
        
        containerView.addSubview(readMoreButton)
        readMoreButton.anchor(top: title1body.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 134, height: 42)
        
        containerView.addSubview(newsTitle)
        newsTitle.anchor(top: readMoreButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(news1date)
        news1date.anchor(top: newsTitle.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(news1body)
        news1body.anchor(top: news1date.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(news2date)
        news2date.anchor(top: news1body.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(news2body)
        news2body.anchor(top: news2date.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(news3date)
        news3date.anchor(top: news2body.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(news3body)
        news3body.anchor(top: news3date.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(viewAllNews)
        viewAllNews.anchor(top: news3body.bottomAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, padddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(videoTitle)
        videoTitle.anchor(top: viewAllNews.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 40, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(videoDate)
        videoDate.anchor(top: videoTitle.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(videoThumbnail)
        videoThumbnail.anchor(top: videoDate.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 258)
        
        containerView.addSubview(videoPlayButton)
        videoPlayButton.anchor(top: videoPlayButton.topAnchor, left: videoPlayButton.leftAnchor, bottom: videoPlayButton.bottomAnchor, right: videoPlayButton.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        videoPlayButton.centerYAnchor.constraint(equalTo: videoThumbnail.centerYAnchor).isActive = true
        videoPlayButton.centerXAnchor.constraint(equalTo: videoThumbnail.centerXAnchor).isActive = true
        
        containerView.addSubview(videoTextbody)
        videoTextbody.anchor(top: videoThumbnail.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        containerView.addSubview(footerContainer)
        footerContainer.anchor(top: videoTextbody.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, padddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        footerContainer.addSubview(footerSchool)
        footerSchool.anchor(top: footerContainer.topAnchor, left: footerContainer.leftAnchor, bottom: nil, right: footerContainer.rightAnchor, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        footerContainer.addSubview(footerAddress)
        footerAddress.anchor(top: footerSchool.bottomAnchor, left: footerContainer.leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        footerContainer.addSubview(footerFollowUs)
        footerFollowUs.anchor(top: footerAddress.bottomAnchor, left: footerContainer.leftAnchor, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        footerContainer.addSubview(footerStack)
        footerStack.anchor(top: footerFollowUs.bottomAnchor, left: footerContainer.leftAnchor, bottom: nil, right: nil, padddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        footerContainer.addSubview(footerCopyRight)
        footerCopyRight.anchor(top: nil, left: nil, bottom: footerContainer.bottomAnchor, right: nil, padddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        footerCopyRight.centerXAnchor.constraint(equalTo: footerContainer.centerXAnchor).isActive = true
        
    }
    
    
}
