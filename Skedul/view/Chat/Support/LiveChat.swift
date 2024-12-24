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
            .zEWidget-launcher { display: none !important; } 
            .zEWidget-closeButton { display: none !important; }
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
                    let jsCode = "zE('webWidget').show();"
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = scene.windows.first(where: { $0.isKeyWindow }),
                           let webView = window.rootViewController?.view.subviews.first(where: { $0 is WKWebView }) as? WKWebView {
                            webView.evaluateJavaScript(jsCode, completionHandler: nil)
                        }
                    }
                }
            }
    }
}

#Preview {
    LiveChat()
}
