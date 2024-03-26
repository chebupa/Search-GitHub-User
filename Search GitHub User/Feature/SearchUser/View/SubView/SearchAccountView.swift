//
//  SearchAccountView.swift
//  Search GitHub User
//
//  Created by aristarh on 17.03.2024.
//

import SwiftUI

struct SearchAccountView: View {
	
	@Binding var user: GHUser?
	@Binding var webIsPresented: Bool
	
	@State private var feedback: Bool = false
	
	var body: some View {
		
		if user != nil {
			VStack {
				AsyncImage(url: user?.avatarUrl) { image in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
						.background(.red)
						.clipShape(Circle())
						.foregroundStyle(
							.blue.gradient.shadow(
								.inner(color: .black, radius: 10)
							)
						)
				} placeholder: {
					Circle()
						.foregroundStyle(.secondary)
				}
				.frame(width: 200, height: 200)
				
				Text(user?.login ?? "no username")
					.bold()
					.font(.system(size: 50))
					.multilineTextAlignment(.center)
				
				Text(user?.bio ?? "")
					.multilineTextAlignment(.center)
				
				Button("Learn more") {
					webIsPresented.toggle()
					feedback.toggle()
				}
				.buttonStyle(BorderedProminentButtonStyle())
				.padding()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.padding(.top, 64)
			.transition(.asymmetric(insertion: .scale, removal: .opacity))
			.sensoryFeedback(.impact(flexibility: .soft),
							 trigger: feedback)
		}
		
		else {
			Text("No user was searched")
		}
	}
}

#Preview {
	SearchAccountView(user: .constant(GHUser(login: "asd",
											 avatarUrl: URL(string: "https://example.com/")!,
											 bio: "asd")),
					  webIsPresented: .constant(false)
	)
}
