//
//  UserManager.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/24/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
    }
    
    init(
        userId: String,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil
    ) {
        self.userId = userId
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
    }

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decode(String.self, forKey: .email)
        self.photoUrl = try container.decode(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.photoUrl, forKey: .photoUrl)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.isPremium, forKey: .isPremium)
    }
    
}

final class UserManager {
    
    static let shared = UserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private init() {}
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let result = try await userDocument(userId: userId).getDocument().data(as: DBUser.self)
        print("result \(result)")
        return result
    }
    
    func updateUserPremiumStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }
    
    func updateUserPremiumStatus(user: DBUser, isPremium: Bool) async throws {
        var data: [String: Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
        ]
        
        try await userDocument(userId: user.userId).updateData(data)
    }
    
}
