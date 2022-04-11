//
//  ResistrationViewController.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/05.
//

import UIKit
import SafariServices

class ResistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
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
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Eamil"
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
    
    private let registButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registButton.addTarget(self, action: #selector(didTapRegistButton), for: .touchUpInside)

        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        userNameField.frame = CGRect(x: 25, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52.0)
        emailField.frame = CGRect(x: 25, y: userNameField.bottom+10, width: view.width-40, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-40, height: 52.0)
        registButton.frame = CGRect(x: 25, y: passwordField.bottom+10, width: view.width-40, height: 52.0)
    }
    
    private func addSubviews() {
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registButton)
        
        view.backgroundColor = .systemBackground
    }
    
    
    @objc private func didTapRegistButton() {
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8, let username = userNameField.text, !username.isEmpty else {
            return
        }
    }
}

extension ResistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapRegistButton()
        }
        
        return true
    }
}
