//
//  SettingViewController.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/05.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View controller to show user Settings
final class SettingViewController: UIViewController {
    
    enum SettingURLType {
        case terms, privacy, help
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPost()
            })
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Services", handler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            SettingCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        
        data.append([
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapLogout()
            })
        ])
    }
    
    private func openUrl(type: SettingURLType) {
        let urlString: String
        
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends() {
        // Show share sheet to invire friends
    }
    
    private func didTapSaveOriginalPost() {
        
    }
    
    private func didTapLogout() {
        let actionSheet = UIAlertController(title: "LogOut", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "LogOut", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        // present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        // error
                        fatalError("Could not log out user")
                    }
                }
            }
        }))
        
        // ipad layout setting
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell select
        data[indexPath.section][indexPath.row].handler()
    }
}
