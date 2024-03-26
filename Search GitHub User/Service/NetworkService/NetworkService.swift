//
//  NetworkService.swift
//  Search GitHub User
//
//  Created by aristarh on 13.03.2024.
//

import Foundation

private protocol NetworkServiceProtocol {
	var decoder: JSONDecoder { get }
	
	func createURL(user: String) throws -> URL
	func getUser(_ user: String) async throws -> GHUser
}

final class NetworkService: NetworkServiceProtocol {
	
	// singleton
	static let shared = NetworkService(); private init() {}
	
	// inits
	fileprivate let decoder = JSONDecoder()
	
	// API methods
	func createURL(user: String) throws -> URL {
		
		let tunnel = "https://"
		let server = "api.github.com/"
		let endpoint = "users/"
		let getParams = user
		
		guard let url = URL(string: tunnel + server + endpoint + getParams) else { throw GHError.invalidURL }
		
		return url
		
	}
	
	func getUser(_ user: String) async throws -> GHUser {
		
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		let (data, response) = try await URLSession.shared.data(from: createURL(user: user))
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkServiceError.responseFailed
		}
		
		guard let result = try? decoder.decode(GHUser.self, from: data) else {
			throw NetworkServiceError.decodingFailed
		}
		
		return result
		
	}
	
//	func get() async throws -> {}
	
}
