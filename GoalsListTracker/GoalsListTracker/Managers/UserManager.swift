//
//  UserManager.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
}

final class UserManager {
    
    static let shared = UserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp(),
            "email": auth.email ?? "",
            "photoUrl": auth.photoUrl ?? ""
        ]
        
        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await userDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(),
              let userId = data["user_id"] as? String
        else {
            throw URLError(.badServerResponse)
        }
        
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
        
    }
    
}

