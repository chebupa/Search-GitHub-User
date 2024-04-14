//
//  SearchUserViewModel.swift
//  Search GitHub User
//
//  Created by aristarh on 17.03.2024.
//

import Foundation
import Observation

@Observable
final class SearchGHUserViewModel {
	
	var user: GHUser?
	var searchedUser: String = ""
	var webViewURL: URL = URL(string: "https://github.com")!
	var webIsPresented: Bool = false
	var alertIsShown: Bool = false
	
	init(searchedUser: String = "", webIsPresented: Bool = false, alertIsShown: Bool = false) {
		self.searchedUser = searchedUser
		self.webIsPresented = webIsPresented
		self.alertIsShown = alertIsShown
	}
	
	func searchUser() async throws -> Void {
		
		webViewURL.deleteLastPathComponent()
		
		guard let result = try? await NetworkService.shared.getUser(searchedUser) else {
			throw SearchGHUserErrors.NetworkError
		}
		
		user = result
		searchedUser = result.login
		webViewURL.append(path: result.login)
	}
}
