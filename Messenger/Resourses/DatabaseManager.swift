//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Hello on 12/21/22.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

struct ChatAppUser {
    
    let firstName: String
    let lastName: String
    let emailAdress: String
//        let profilePicture: String
}

// MARK: - Account Management
extension DatabaseManager {
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value) { snapShot in
            guard snapShot.value as? String != nil else {
                return
            }
            completion(true)
        }
        
    }
    
    // Insert new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAdress).setValue(["first_name": user.firstName,
                                                   "last_name": user.lastName
                                                    ])
    }

    
}
