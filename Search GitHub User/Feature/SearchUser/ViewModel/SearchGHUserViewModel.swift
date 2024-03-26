//
//  SearchUserViewModel.swift
//  Search GitHub User
//
//  Created by aristarh on 17.03.2024.
//

import Foundation
import Observation

public enum SearchGHUserErrors: Error {
	case NetworkError
}

internal protocol SearchGHUserViewModelProtocol {
	var user: GHUser? { get set }
	var searchedUser: String { get set }
	var webViewURL: URL { get set }
	var webIsPresented: Bool { get set }
	var alertIsShown: Bool { get set }
	
	func searchUser() async throws -> GHUser
}

@Observable
internal final class SearchGHUserViewModel: SearchGHUserViewModelProtocol {
	
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
	
	func searchUser() async throws -> GHUser {
		
		webViewURL.deleteLastPathComponent()
		
		guard let result = try? await NetworkService.shared.getUser(searchedUser) else {
			throw SearchGHUserErrors.NetworkError
		}
		
		user = result
		webViewURL.append(path: result.login)
		
		return result
	}
}
