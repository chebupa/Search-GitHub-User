//
//  ContentView.swift
//  Search GitHub User
//
//  Created by aristarh on 13.03.2024.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			SearchGHUserView()
				.tabItem {
					Image(systemName: "magnifyingglass")
					Text("Search")
				}
			
			UserScreenView()
				.tabItem {
					Image(systemName: "person")
					Text("User")
				}
		}
	}
}

#Preview {
	ContentView()
}
