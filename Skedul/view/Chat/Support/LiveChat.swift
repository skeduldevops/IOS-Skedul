//
//  LiveChat.swift
//  Skedul
//
//  Created by skedul on 10/12/24.
//

import SwiftUI
import WebKit

struct LiveChat: View {
    let htmlString = """
    <html>
    <head>
        <style>
            body, html {
                margin: 0;
                padding: 0;
                overflow: hidden;
            }
            .zEWidget-launcher {
                display: none !important;
            }
        </style>
    </head>
    <body>
        <script id="ze-snippet" src="https://static.zdassets.com/ekr/snippet.js?key=13ad9fc9-8635-4e39-9d3a-9185a0a2ebbb"></script>
    </body>
    </html>
    """
    
    var body: some View {
        WebView(htmlString: htmlString)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    DispatchQueue.main.async {
                        self.executeJavaScriptToShowWidget()
                    }
                }
            }
    }
    
    private func executeJavaScriptToShowWidget() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first(where: { $0.isKeyWindow }),
              let rootViewController = window.rootViewController else {
            print("Error: Unable to locate root view controller.")
            return
        }
        
        guard let webView = findWKWebView(in: rootViewController.view) else {
            print("Error: WKWebView not found in the view hierarchy.")
            return
        }

        let jsCode = "if (typeof zE === 'function') { zE('webWidget').show(); } else { console.error('Zendesk WebWidget not loaded.'); }"
        
        webView.evaluateJavaScript(jsCode) { (result, error) in
            if let error = error {
                print("JavaScript execution failed: \(error.localizedDescription)")
            } else {
                print("JavaScript executed successfully: \(result ?? "No result")")
            }
        }
    }

    private func findWKWebView(in view: UIView) -> WKWebView? {
        if let webView = view as? WKWebView {
            return webView
        }
        for subview in view.subviews {
            if let webView = findWKWebView(in: subview) {
                return webView
            }
        }
        return nil
    }
}


#Preview {
    LiveChat()
}
