//
//  LoginViewController.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/05.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.borderWidth = 1.0
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.borderWidth = 1.0
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gredient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign Frame
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height/3.0)
        
        userNameEmailField.frame = CGRect(x: 25, y: headerView.bottom+40, width: view.width-50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: userNameEmailField.bottom+10, width: view.width-50, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom+10, width: view.width-50, height: 52.0)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom+10, width: view.width-50, height: 52.0)
        
        termsButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
        configureHeaderView()
    }
    
    private func addSubviews() {
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(headerView)
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        // Add Instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4 , y: view.safeAreaInsets.top, width: headerView.width/2.0, height: headerView.height-view.safeAreaInsets.top)
    }
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let usernameEmail = userNameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        // Login
    }
    
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = ResistrationViewController()
        present(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}
