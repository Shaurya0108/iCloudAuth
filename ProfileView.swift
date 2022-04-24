//
//  ProfileView.swift
//  icloudauthapp
//
//  Created by shaurya on 1/9/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack{
            Image("background-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16){
                        ZStack{
                            Circle()
                                .foregroundColor(Color("pink-gradient-1"))
                                .frame(width: 66, height: 66, alignment: .center)
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .medium, design: .rounded))
                        }
                        .frame(width: 66, height: 66, alignment: .center)
                        
                        VStack(alignment: .leading){
                            Text("Your Name")
                                    .foregroundColor(.white)
                                    .font(.title2).bold()
                            
                            Text("View Profile")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.footnote).bold()
                        }
                        
                        Spacer()
                        
                        Button(action: {
                        print("Segue to settings")
                        }, label: {
                            TextFieldIcon(iconName: "gearshape.fill", currentlyEditing: .constant(true))
                        })
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    Text("Bio about you")
                        .foregroundColor(.white)
                        .font(.title3.bold())
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.1))
                    
                    HStack(spacing: 16){
                        Image("Twitter")
                            .resizable()
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Image(systemName: "link")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                    }
                }
                .padding(16)
                
                gradientButton(buttonTitle: "Purchase") {
                    print("WOAH")
                }
                .padding(.horizontal, 16)
                
                
                Button(action: {
                    print("Restore")
                }, label: {
                    gradientText(text: "What should this button do")
                        .font(.footnote.bold())
                })
                    .padding(.bottom)
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.2))
                    .background(Color("secondaryBackground").opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .dark))
                    .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
            .padding(.horizontal)
            
            VStack{
                Spacer()
                Button(action: {
                    print("Sign Out")
                }, label: {
                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 0.0, z: 1.0)
                        )
                        .background(
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 42, height: 42, alignment: .center)
                                .overlay(
                                    VisualEffectBlur(blurStyle: .dark)
                                        .cornerRadius(21)
                                        .frame(width: 42, height: 42, alignment: .center)
                                )
                        )
                })
            }
            .padding(.bottom, 64)
        }
        .colorScheme(.dark)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
