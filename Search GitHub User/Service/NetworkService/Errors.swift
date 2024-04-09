//
//  Errors.swift
//  Search GitHub User
//
//  Created by aristarh on 13.03.2024.
//

import Foundation

enum NetworkServiceError: Error {
	case invalidURL
	case invalidResponse
	case decodingFailed
}
