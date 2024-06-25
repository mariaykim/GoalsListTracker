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
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
    }
}

final class UserManager {
    
    static let shared = UserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = { // The firestore db uses snake case
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = { // The firestore db uses snake case
        let encoder = Firestore.Decoder()
        encoder.keyDecodingStrategy = .convertFromSnakeCase
        return encoder
    }()
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private init() {}
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument().data(as: DBUser.self, decoder: decoder)
    }
    
}
