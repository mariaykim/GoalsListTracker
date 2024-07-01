//
//  GoalsListView.swift
//  GoalsListTracker
//
//  Created by Maria Kim on 6/25/24.
//

import SwiftUI

struct GoalsListView: View {
    
    @StateObject private var viewModel = GoalsListViewViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.goals, id: \.id) { goal in
                    Text("title: \(goal.title)")
                }
            }
            .navigationTitle("Goals")
            .toolbar {
                EditButton()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    NavigationLink(destination: {
                        ProfileView(showSignInView: $showSignInView)
                    }, label: {
                        Image(systemName: "person.circle")
                            .font(.headline)
                    })
                })
            }
        }
    }
}
