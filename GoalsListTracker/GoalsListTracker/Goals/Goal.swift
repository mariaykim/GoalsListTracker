//
//  Goal.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/25/24.
//

import Foundation

struct Goal: Codable {
    let id: String
    let title: String
    let description: String?
    let goalDate: Date
    let goalCompletedDate: Date?
    let goalCompleted: Bool
    
    init(id: String, 
         title: String,
         description: String? = nil,
         goalDate: Date,
         goalCompletedDate: Date? = nil,
         goalCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.goalDate = goalDate
        self.goalCompletedDate = goalCompletedDate
        self.goalCompleted = goalCompleted
    }
}
