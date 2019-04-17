//
//  SignupController.swift
//  TeamGAproject
//
//  Created by sowah on 3/23/19.
//  Copyright © 2019 sowah. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let addProfileImage: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "team-placeholder"), for: .normal)
        button.layer.cornerRadius = 126/2
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.isEnabled = true
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusPhoto() {
        print("tap")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addProfileImage.setImage(editingImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            addProfileImage.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "@ucd.edu.com"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange() {
        if phoneTextField.text?.count == 3 {
            phoneTextField.text?.append("-")
        } else if phoneTextField.text?.count == 7 {
            phoneTextField.text?.append("-")
        }
        emailTextField.text = usernameTextField.text?.appending("@ucd.edu")
        
        let isFormVaild = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormVaild {
            signUpButton.backgroundColor = #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)
            signUpButton.isEnabled = true
        }
        else {
            signUpButton.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            signUpButton.isEnabled = false
        }
    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let positionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Position"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Phone"
        tf.keyboardType = .phonePad
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let officeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Office"
        tf.keyboardType = .numberPad
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.layer.cornerRadius = 21
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignUp() {
        ProgressHUD.show("Waiting...", interaction: true)
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let position = positionTextField.text, position.count > 0 else { return }
        guard let phone = phoneTextField.text, phone.count > 0 else { return }
        guard let office = officeTextField.text, office.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user: AuthDataResult?, error: Error?) in
            if let err = error {
                ProgressHUD.showError("\(err)", interaction: false)
                return
            }
            
            ProgressHUD.showSuccess("success created user", interaction: false)
            guard let image = self.addProfileImage.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_image").child(filename)
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err {
                    print("failed to upload profile image:", err)
                }
                
                storageRef.downloadURL(completion: {(downloadURL, err) in
                    if let err = err {
                        print("failed to fetch downloadURL:", err)
                        return
                    }
                    
                    guard let profileImageUrl = downloadURL?.absoluteString else { return }
                    guard let uid = user?.user.uid else { return }

                    let dictionaryValues = ["username": username, "position": position, "phone": phone, "office": office, "email": email, "profileImageUrl": profileImageUrl]
                    let values = [uid: dictionaryValues]
                    
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if let err = err {
                            ProgressHUD.showError("fail to create an account", interaction: false)
                            print("Fail to save user info into db:, err", err)
                            return
                        }
                        
                        ProgressHUD.showSuccess("Successfully creating an account", interaction: false)
                        print("Successfully saved user info to db")
                        guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                        mainTabBarController.setUpViewController()
                        self.dismiss(animated: true, completion: nil)
                    })
                })
            })

        }
    }
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2747907639, green: 0.5571715236, blue: 0.8975776434, alpha: 1)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAlreadyHaveAccount() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 740)
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        containerView.addSubview(addProfileImage)
        addProfileImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        addProfileImage.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, padddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 126, height: 126)
        
        containerView.addSubview(emailTextField)
        setupInputfields()
        scrollView.keyboardDismissMode = .onDrag
        emailTextField.delegate = self
        usernameTextField.delegate = self
        positionTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        officeTextField.delegate = self
    }
    
    fileprivate func setupInputfields() {
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, positionTextField, phoneTextField, officeTextField, emailTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        containerView.addSubview(stackView)
        
        stackView.anchor(top: addProfileImage.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 350)
        
        containerView.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: stackView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, padddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
}

extension SignupController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
}
