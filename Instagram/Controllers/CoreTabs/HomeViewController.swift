//
//  HomeViewController.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/05.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Check Auth Status
        if Auth.auth().currentUser == nil {
            // Show Login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
    }
}

