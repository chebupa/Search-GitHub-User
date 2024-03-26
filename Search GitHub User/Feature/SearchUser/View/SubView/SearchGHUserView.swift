//
//  HomeScreenView.swift
//  Search GitHub User
//
//  Created by aristarh on 16.03.2024.
//

import SwiftUI

struct SearchGHUserView: View {
	
	@State var user: GHUser?
	@State private var searchedUser = ""
	@State private var webIsPresented = false
	
    var body: some View {
		NavigationStack {
			ScrollView {
				VStack(spacing: 20) {
					SearchAccountView(user: $user,
									  searchedUser: $searchedUser,
									  webIsPresented: $webIsPresented)
				}
				.padding()
				.sheet(isPresented: $webIsPresented) {
					WebView(url: URL(string: "https://github.com/\(String(describing: user?.login))")!)
				}
				
			}
			.navigationTitle("Search")
		}
		.searchable(text: $searchedUser)
		.onSubmit(of: .search) {
			Task {
				do {
					user = try await NetworkService.shared.getUser(searchedUser)
				} catch {}
			}
		}
    }
}

#Preview {
	SearchGHUserView()
}
