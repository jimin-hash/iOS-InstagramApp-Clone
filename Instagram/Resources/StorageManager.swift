//
//  StorageManager.swift
//  Instagram
//
//  Created by 박지민 on 2022/04/07.
//

import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPhotoPost(model: UserPost, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }

            completion(.success(url))
        })
    }
    
}
