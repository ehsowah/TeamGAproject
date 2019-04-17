//
//  LoginController.swift
//  TeamGAproject
//
//  Created by sowah on 3/22/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let logoLable: UILabel = {
        let label = UILabel()
        let AttributedText = NSMutableAttributedString(string: "University Community District\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        AttributedText.append(NSMutableAttributedString(string: "North Pittsburg, PA", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        label.attributedText = AttributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let logoImage: CustomImageView = {
        let image = CustomImageView()
        image.image = #imageLiteral(resourceName: "UDClogo-1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let usernameIcon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "icons8-person-64")
        return image
    }()
    
    let passwordIcon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "password")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "user@ucd.edu", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    @objc func handleTextInputChange() {
        let isFormVaild = usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormVaild {
            loginButton.backgroundColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
            loginButton.isEnabled = true
        }
        else {
            loginButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            loginButton.isEnabled = false
        }
    }
    
    let usernameLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let attributeText = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white])
        button.setAttributedTitle(attributeText, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLogin() {
        ProgressHUD.show("Waiting...", interaction: false)
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                ProgressHUD.showError(err as? String)
                return
            }
            ProgressHUD.showSuccess("Success", interaction: false)
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setUpViewController()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let createAccountButton: UIButton = {
        let button = UIButton()
        let attributeText = NSAttributedString(string: "Create Account", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)])
        button.setAttributedTitle(attributeText, for: .normal)
        button.titleLabel?.textColor = .black
        button.setTitleColor(#colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleShowsSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowsSignUp() {
        let signUpController = SignupController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow
        loginButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 740)
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        containerView.addSubview(logoLable)
        logoLable.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, padddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoLable.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(logoImage)
        logoImage.anchor(top: logoLable.bottomAnchor, left: nil, bottom: nil, right: nil, padddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 156, height: 156)
        logoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(usernameIcon)
        usernameIcon.anchor(top: logoImage.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, padddingTop: 38, paddingLeft: 64, paddingBottom: 0, paddingRight: 0, width: 23, height: 23)
        
        containerView.addSubview(usernameTextField)
        usernameTextField.anchor(top: logoImage.bottomAnchor, left: usernameIcon.rightAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 38, paddingLeft: 10, paddingBottom: 0, paddingRight: 64, width: 0, height: 0)
        
        containerView.addSubview(usernameLine)
        usernameLine.anchor(top: usernameTextField.bottomAnchor, left: usernameIcon.leftAnchor, bottom: nil, right: usernameTextField.rightAnchor, padddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        containerView.addSubview(passwordIcon)
        passwordIcon.anchor(top: usernameLine.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, padddingTop: 35, paddingLeft: 64, paddingBottom: 0, paddingRight: 0, width: 23, height: 23)
        
        containerView.addSubview(passwordTextField)
        passwordTextField.anchor(top: usernameLine.bottomAnchor, left: passwordIcon.rightAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 35, paddingLeft: 10, paddingBottom: 0, paddingRight: 64, width: 0, height: 0)
        
        containerView.addSubview(passwordLine)
        passwordLine.anchor(top: passwordTextField.bottomAnchor, left: passwordIcon.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, padddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        containerView.addSubview(loginButton)
        loginButton.anchor(top: passwordLine.bottomAnchor, left: passwordLine.leftAnchor, bottom: nil, right: passwordLine.rightAnchor, padddingTop: 56, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 42)
        
        containerView.addSubview(createAccountButton)
        createAccountButton.anchor(top: loginButton.bottomAnchor, left: passwordLine.leftAnchor, bottom: nil, right: passwordLine.rightAnchor, padddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 42)
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        scrollView.keyboardDismissMode = .onDrag
    }
    
    
}

extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 120), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
