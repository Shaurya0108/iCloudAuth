//
//  ContentView.swift
//  icloudauthapp
//
//  Created by shaurya on 1/6/22.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth

struct SignupView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmailTextField: Bool = false
    @State private var editingPasswordTextField: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView: Bool = false
    @State private var signupToggle: Bool = true
    @State private var rotationAngle = 0.0
    @State private var fadeToggle: Bool = true
    
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack{
            Image(signupToggle ? "background-2" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 1.0 : 0.0)
            
            Color("secondaryBackground")
                .edgesIgnoringSafeArea(.all)
                .opacity(fadeToggle ? 0 : 1.0)
            
            VStack{
                VStack(alignment: .leading, spacing: 16){
                    Text(signupToggle ? "Sign Up" : "Sign In")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text(signupToggle ? "Create an account!" : "Sign In with your account")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .opacity(0.8)
                    HStack{
                        TextFieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextField)
                            .scaleEffect(emailIconBounce ? 1.1 : 1.0)
                        TextField("Email", text: $email){
                            isEditing in
                            editingEmailTextField = isEditing
                            editingPasswordTextField = false
                            generator.selectionChanged()
                            if isEditing{
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                        }
                        .colorScheme(.dark)
                        .foregroundColor(Color.white.opacity(0.7))
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    }
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1.5)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    HStack{
                        TextFieldIcon(iconName: "lock.fill", currentlyEditing: $editingPasswordTextField)
                            .scaleEffect(passwordIconBounce ? 1.1 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1.5)
                            .blendMode(.overlay)
                    )
                    .background(
                        Color("secondaryBackground")
                            .cornerRadius(16)
                            .opacity(0.8)
                    )
                    .onTapGesture{
                        editingPasswordTextField = true
                        editingEmailTextField = false
                        generator.selectionChanged()
                        if editingPasswordTextField{
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                passwordIconBounce.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)){
                                    passwordIconBounce.toggle()
                                }
                            }
                        }
                    }
                    
                    gradientButton(buttonTitle: signupToggle ? "Create Account" : "Sign In"){
                        generator.selectionChanged()
                        signUp()
                    }
                    .onAppear{
                        Auth.auth()
                            .addStateDidChangeListener { auth, user in
                                if user != nil{
                                    showProfileView.toggle()
                                }
                            }
                    }
                    
                    /*
                     Text("By Signing up you have agreed to the terms of service and Privacy policy")
                     .font(.footnote)
                     .foregroundColor(Color.white.opacity(0.4))
                     */
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.4))
                    
                    VStack(alignment: .leading, spacing: 16, content: {
                        Button(action: {
                            
                            withAnimation(.easeInOut(duration: 0.35)){
                                fadeToggle.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    withAnimation(.easeInOut(duration: 0.35)){
                                        self.fadeToggle.toggle()
                                    }
                                }
                            }
                            
                            withAnimation(.easeInOut(duration: 0.7)) {
                                signupToggle.toggle()
                                self.rotationAngle += 180
                            }
                        }, label: {
                            HStack(spacing: 4){
                                Text(signupToggle ? "Already have an account?" : "Don't have an account?")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.4))
                                gradientText(text: signupToggle ? "Sign in" : "Sign up")
                                    .font(Font.footnote.bold())
                                    .padding(10)
                            }
                        })
                        if !signupToggle{
                            Button(action: {
                                sendPasswordResetEmail()
                            }, label: {
                                HStack(spacing: 4){
                                    Text("Forgot Password?")
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.7))
                                    gradientText(text: "Reset Password")
                                        .font(.footnote.bold())
                                        .padding(10)
                                }
                            })
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white
                                .opacity(0.1))
                            
                            Button(action: {
                                print("Sign in with Apple")
                            }, label: {
                                signInWithApple()
                                    .frame(height: 50)
                                    .cornerRadius(16)
                            })
                        }
                    })
                    
                }
                .padding(20)
            }
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.7))
                    .background(Color("settingsBackground")).opacity(0.5)
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
            .alert(isPresented: $showAlertView){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
            }
        }/*
          .fullScreenCover(isPresented: $showProfileView) {
          ProfileView()
          }*/
    }
    
    func signUp(){
        if signupToggle{
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    self.alertTitle = "ohh ohk"
                    self.alertMessage = (error!.localizedDescription)
                    self.showAlertView.toggle()
                    return
                }
            }
        }
        else{
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    alertTitle = "Ohh ohk"
                    alertMessage = (error!.localizedDescription)
                    showAlertView.toggle()
                    return
                }
            }
        }
    }
    
    func sendPasswordResetEmail(){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else{
                print (error!.localizedDescription)
                return
            }
            alertTitle = "Password email sent"
            alertMessage = "Check your email's inbox for a password reset email"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
