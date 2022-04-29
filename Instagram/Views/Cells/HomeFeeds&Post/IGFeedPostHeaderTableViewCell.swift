//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Jimin Park on 2022/04/19.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // Configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
