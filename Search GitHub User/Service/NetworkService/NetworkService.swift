//
//  NetworkService.swift
//  Search GitHub User
//
//  Created by aristarh on 13.03.2024.
//

import Foundation

public final class NetworkService {
	
	// singleton
	static let shared = NetworkService(); private init() {}
	
	// inits
	private let decoder = JSONDecoder()
	
	// Helpers
	private func createURL(tunnel: String = "https://",
						   server: String = "api.github.com/",
						   endpoint: String = "users/",
						   params: String) throws -> URL {
		
		guard let url = URL(string: tunnel + server + endpoint + params) else {
			throw NetworkServiceError.invalidURL
		}
		
		return url
	}
	
	// API methods
	func getUser(_ user: String) async throws -> GHUser {
		
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		let (data, response) = try await URLSession.shared.data(from: createURL(params: user))
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw NetworkServiceError.invalidResponse
		}
		
		guard let result = try? decoder.decode(GHUser.self, from: data) else {
			throw NetworkServiceError.decodingFailed
		}
		
		return result
	}
}
