//
//  WebView.swift
//  Search GitHub User
//
//  Created by aristarh on 16.03.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

	let url: URL
	
	func makeUIView(context: Context) -> WKWebView {
		
		return WKWebView()
	}
	
	func updateUIView(_ webView: WKWebView, context: Context) {
		
		let request = URLRequest(url: url)
		webView.load(request)
	}
}
