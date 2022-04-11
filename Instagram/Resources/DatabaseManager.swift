//
//  DatabaseManager.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/07.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database()
    
    // MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        
    }
    
    /// Insert new user data to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func insertNewUser(with email: String, username: String) {
        
    }
}
