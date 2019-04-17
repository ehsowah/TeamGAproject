//
//  TimerController.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class TimerController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let greetLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let currentDate: UILabel = {
        let label = UILabel()
        label.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: .none)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()
    
    let currentTime: UILabel = {
        let label = UILabel()
        label.text = "9:15 AM"
        label.font = UIFont.boldSystemFont(ofSize: 63)
        label.textColor = .darkGray
        return label
    }()
    
    let clockInTitle: UILabel = {
        let lable = UILabel()
        lable.text = "Start Time"
        return lable
    }()
    
    let clockOutTitle: UILabel = {
        let lable = UILabel()
        lable.text = "End Time"
        return lable
    }()
    
    let clockInField: UITextField = {
        let label = UITextField()
        label.borderStyle = .roundedRect
        return label
    }()
    
    let clockOutField: UITextField = {
        let label = UITextField()
        label.borderStyle = .roundedRect
        return label
    }()
    
    let clockInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clock In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6769199967, green: 0.8966200352, blue: 0.4247659743, alpha: 1)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleClockInButton), for: .touchUpInside)
        return button
    }()
    
    let clockOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clock Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8909497857, green: 0.3672434092, blue: 0.4278458357, alpha: 1)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleClockOutButton), for: .touchUpInside)
        return button
    }()
    
    let AcceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleAcceptButton), for: .touchUpInside)
        return button
    }()
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateTime")
    @objc func handleAcceptButton() {
    
        guard let currentDate = currentDate.text else { return }
        guard let clockinTime = clockInField.text else { return }
        guard let clockoutTime = clockOutField.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["currentDate": currentDate, "clockin": clockinTime, "clockOut": clockoutTime, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        Database.database().reference().child("timers").child(uid).childByAutoId().updateChildValues(values) { (err, ref) in
            if let err = err {
                ProgressHUD.showSuccess("fail", interaction: true)
                return
            }
            
            ProgressHUD.showSuccess("Success", interaction: true)
            NotificationCenter.default.post(name: TimerController.updateFeedNotificationName, object: nil)
        }
        
        clockInField.text = ""
        clockOutField.text = ""
        
        AcceptButton.backgroundColor = .lightGray
        AcceptButton.isEnabled = false
        
        clockInButton.backgroundColor = #colorLiteral(red: 0.6769199967, green: 0.8966200352, blue: 0.4247659743, alpha: 1)
        clockInButton.isEnabled = true
    }
    
    @objc func handleClockInButton() {
        let clockInTime = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.none, timeStyle: .short)
        clockInField.text = "\(clockInTime)"
  
        clockInButton.backgroundColor = .lightGray
        clockInButton.isEnabled = false
        
        clockOutButton.backgroundColor = #colorLiteral(red: 0.8909497857, green: 0.3672434092, blue: 0.4278458357, alpha: 1)
        clockOutButton.isEnabled = true
        
    }
    
    @objc func handleClockOutButton() {
        let clockOutTime = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.none, timeStyle: .short)
        clockOutField.text = "\(clockOutTime)"
        
        clockOutButton.backgroundColor = .lightGray
        clockOutButton.isEnabled = false
        
        AcceptButton.backgroundColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        AcceptButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Clock In/Out"
        view.backgroundColor = .white
        setUpGreetingLables()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        fetchUser()
        scrollView.keyboardDismissMode = .onDrag
        
        AcceptButton.backgroundColor = .lightGray
        clockOutButton.backgroundColor = .lightGray
        AcceptButton.isEnabled = false
        clockOutButton.isEnabled = false
    }
    
    func setUpGreetingLables() {
        
        let stackView = UIStackView(arrangedSubviews: [greetLabel, userNameLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 650)
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, padddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(currentDate)
        currentDate.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        currentDate.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(currentTime)
        currentTime.anchor(top: currentDate.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        currentTime.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        let startStack = UIStackView(arrangedSubviews: [clockInTitle, clockInField])
        startStack.axis = .vertical
        startStack.distribution = .fillProportionally
        startStack.spacing = 5
        
        let endStack = UIStackView(arrangedSubviews: [clockOutTitle, clockOutField])
        endStack.axis = .vertical
        endStack.distribution = .fillProportionally
        endStack.spacing = 5
        
        let startEndStack = UIStackView(arrangedSubviews: [startStack, endStack])
        startEndStack.axis = .horizontal
        startEndStack.distribution = .fillEqually
        startEndStack.spacing = 10
        
        containerView.addSubview(startEndStack)
        startEndStack.anchor(top: currentTime.bottomAnchor, left: currentTime.leftAnchor, bottom: nil, right: currentTime.rightAnchor, padddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        startEndStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [clockInButton, clockOutButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        
        containerView.addSubview(buttonStackView)
        buttonStackView.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 10, paddingBottom: 40, paddingRight: 10, width: 0, height: 60)
        
        containerView.addSubview(AcceptButton)
        AcceptButton.anchor(top: nil, left: buttonStackView.leftAnchor, bottom: buttonStackView.topAnchor, right: buttonStackView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 60)
    }
    
    @objc func updateTime() {
        currentTime.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.none, timeStyle: .short)
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.userNameLabel.text = dictionary["username"] as? String
            self.reloadInputViews()
        }
    }
}

