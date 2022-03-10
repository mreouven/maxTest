//
//  ContentView.swift
//  maxTest
//
//  Created by Reouven Mimoun on 03/03/2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct SAWebView: View {
    
    var body: some View {
        Webview(url: URL(string: "https://www.max-stg.co.il/saving/personal")!)
    }
}

struct Webview: UIViewRepresentable {
    let url: URL
    let navigationHelper = WebViewHelper()

    
    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
       
        let contentController = WKUserContentController();
//        contentController.add(messageHandler, name: "callbackHandler")

        let script = try! String(contentsOf: Bundle.main.url(forResource: "WebRTC", withExtension: "js")!, encoding: String.Encoding.utf8)
        contentController.addUserScript(WKUserScript(source: script, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true))

        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        let webview = WKWebView(frame: CGRect.zero, configuration: config)
        webview.navigationDelegate = navigationHelper

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}

class WebViewHelper: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinishNavigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceiveAuthenticationChallenge")
        completionHandler(.performDefaultHandling, nil)
    }
}
