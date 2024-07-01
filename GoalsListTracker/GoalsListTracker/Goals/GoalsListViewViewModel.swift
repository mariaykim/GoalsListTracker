//
//  GoalsListViewViewModel.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/25/24.
//

import Foundation

@MainActor
final class GoalsListViewViewModel: ObservableObject {
    @Published var goals: [Goal] = [
        .init(id: "1", title: "goal 1", goalDate: Date()),
            .init(id: "2", title: "goal 2", goalDate: Date()),
            .init(id: "3", title: "goal 3", goalDate: Date())
        ]
}
