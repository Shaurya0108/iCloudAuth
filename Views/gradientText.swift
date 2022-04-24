//
//  gradientText.swift
//  icloudauthapp
//
//  Created by shaurya on 1/9/22.
//

import SwiftUI

struct gradientText: View {
    var text: String = "<Text Here>"
    
    var body: some View {
        Text(text)
            .gradiantForeground(colors: [Color("pink-gradient-1"), Color("pink-gradient-2")])
    }
}

extension View{
    public func gradiantForeground(colors: [Color]) -> some View{
        self
            .overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}
