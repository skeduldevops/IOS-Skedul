//
//  TermUse.swift
//  Skedul
//
//  Created by skedul on 18/11/24.
//

import SwiftUI
import WebKit


struct TermUse: View {
    var body: some View {
        NavigationView {
            WebView(htmlString: """
        <div name="termly-embed" data-id="2b146236-34d6-49be-a3d6-892b6e372c79"></div>
        <script type="text/javascript">(function(d, s, id) {
          var js, tjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) return;
          js = d.createElement(s); js.id = id;
          js.src = "https://app.termly.io/embed-policy.min.js";
          tjs.parentNode.insertBefore(js, tjs);
        }(document, 'script', 'termly-jssdk'));</script>
        """)
            .cornerRadius(10)
            
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TermUse()
}
