//
//  SearchFieldView.swift
//  Search GitHub User
//
//  Created by aristarh on 17.03.2024.
//

import SwiftUI

struct SearchFieldView: View {
	
	@Binding var user: GHUser?
	@Binding var searchedUser: String
	
	var body: some View {
		
		TextField("Search by GitHub username", text: $searchedUser)
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.autocorrectionDisabled()
			.onSubmit {
				Task {
					do {
						user = try await NetworkService.shared.getUser(searchedUser)
					} catch {}
				}
			}
		
	}
}

#Preview {
	SearchFieldView(user: .constant(GHUser(login: "asd",
										   avatarUrl: URL(string: "https://example.com/")!,
										   bio: "asd")),
					searchedUser: .constant("")
	)
}
