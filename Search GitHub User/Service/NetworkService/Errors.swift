//
//  Errors.swift
//  Search GitHub User
//
//  Created by aristarh on 13.03.2024.
//

import Foundation

enum GHError: Error {
	case invalidURL
}

enum NetworkServiceError: Error {
	case responseFailed
	case decodingFailed
}
