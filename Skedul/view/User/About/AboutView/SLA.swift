//
//  SLA.swift
//  Skedul
//
//  Created by skedul on 18/11/24.
//

import SwiftUI

struct SLA: View {
    var body: some View {
        
        NavigationView{
            WebView(htmlString: """
        <iframe src="https://drive.google.com/file/d/1VC6Z5CbT_7XFXZw8Ztemupov-m2IxjNg/preview" width="100%" height="480" allow="autoplay"></iframe>
        """)
            .cornerRadius(10)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SLA()
}

