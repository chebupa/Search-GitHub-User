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
			.onSubmit(of: .search) {
				Task {
					do {
						viewModel.searchedUser = try await viewModel.searchUser().login
					} catch {
						viewModel.alertIsShown = true
					}
				}
			}
			.sheet(isPresented: $viewModel.webIsPresented) {
				WebView(url: viewModel.webViewURL)
					.presentationDragIndicator(.visible)
			}
			.alert("Such user doesn't exist",
				   isPresented: $viewModel.alertIsShown) {
				Button("OK", role: .cancel) { }
			}
		}
	}
}

#Preview {
	SearchGHUserView()
}
