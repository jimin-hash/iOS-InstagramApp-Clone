//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Jimin Park on 2022/04/24.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    private var model: UserNotification?
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@jimin liked your photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    @objc private func didTapPostsButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Photo, text, post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-size-profileImageView.width-16, height: contentView.height)
    }
}
