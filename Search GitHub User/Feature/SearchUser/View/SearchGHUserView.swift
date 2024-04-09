//
//  SearchGHUserView.swift
//  Search GitHub User
//
//  Created by aristarh on 21.03.2024.
//

import SwiftUI

struct SearchGHUserView: View {
	
	@State private var viewModel = SearchGHUserViewModel()
	
	var body: some View {
		
		NavigationStack {
			ScrollView {
				SearchAccountView(user: $viewModel.user,
								  webIsPresented: $viewModel.webIsPresented)
			}
			.navigationTitle("Search")
			.searchable(text: $viewModel.searchedUser)
			.sheet(isPresented: $viewModel.webIsPresented) {
				WebView(url: viewModel.webViewURL)
					.presentationDragIndicator(.visible)
			}
			.alert("Such username doesn't exist",
				   isPresented: $viewModel.alertIsShown) {}
			.onSubmit(of: .search) {
				Task {
					do {
						try await viewModel.searchUser()
					} catch {
						viewModel.alertIsShown = true
						print(error)
					}
				}
			}
		}
		
	}
}

#Preview {
	SearchGHUserView()
}
