//
//  SearchGHUserView.swift
//  Search GitHub User
//
//  Created by aristarh on 21.03.2024.
//

import SwiftUI

struct SearchGHUserView: View {
	
	@State private var VM = SearchGHUserViewModel()
	
	var body: some View {
		NavigationStack {
			ScrollView {
				SearchAccountView(user: $VM.user,
								  webIsPresented: $VM.webIsPresented)
			}
			.navigationTitle("Search")
			.searchable(text: $VM.searchedUser)
			.sheet(isPresented: $VM.webIsPresented) {
				WebView(url: VM.webViewURL)
					.presentationDragIndicator(.visible)
			}
			.alert("Such username doesn't exist",
				   isPresented: $VM.alertIsShown) {}
			.onSubmit(of: .search) {
				Task {
					do {
						try await VM.searchUser()
					} catch {
						VM.alertIsShown = true
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
