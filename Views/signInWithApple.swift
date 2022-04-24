//
//  signInWithApple.swift
//  icloudauthapp
//
//  Created by shaurya on 1/10/22.
//

import SwiftUI
import AuthenticationServices

struct signInWithApple: UIViewRepresentable{
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
