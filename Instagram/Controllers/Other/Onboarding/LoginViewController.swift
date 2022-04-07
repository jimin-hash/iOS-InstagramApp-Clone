//
//  LoginViewController.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/05.
//

import UIKit

class LoginViewController: UIViewController {

    private let userNameEmailField: UITextField = {
        return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        return UIButton()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign Frame
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
    
    @objc private func didTapLoginButton() {}
    @objc private func didTapTermsButton() {}
    @objc private func didTapPrivacyButton() {}
    @objc private func didTapCreateAccountButton() {}
}
