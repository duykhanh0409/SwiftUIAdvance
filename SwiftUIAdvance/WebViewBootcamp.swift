//
//  WebViewBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 13/7/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("Started loading")
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finished loading")
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url?.absoluteString {
                print("Navigating to: \(url)")
            }
            decisionHandler(.allow)
        }
    }
}


struct WebViewBootcamp: View {
    var body: some View {
        WebView(url: URL(string: "https://naver.com")!)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    WebViewBootcamp()
}
