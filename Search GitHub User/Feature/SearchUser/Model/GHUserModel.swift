//
//  GHUserModel.swift
//  Search GitHub User
//
//  Created by aristarh on 17.03.2024.
//

import Foundation


struct GHUser: Decodable {
	let login: String
	let avatarUrl: URL
	let bio: String
}
