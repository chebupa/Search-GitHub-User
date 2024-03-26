//
//  UserScreenView.swift
//  Search GitHub User
//
//  Created by aristarh on 16.03.2024.
//

import SwiftUI

struct UserScreenView: View {
    var body: some View {
		
		NavigationStack {
			List {
				Section {
					Text("Puk")
				} header: {
					Text("Main")
				}
			}
			.navigationTitle("Account")
			
//			Link("by chebupa", destination: URL(string: "https://github.com/chebupa")!)
			
		}
    }
}

#Preview {
    UserScreenView()
}
