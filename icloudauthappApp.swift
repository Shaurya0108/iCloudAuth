//
//  icloudauthappApp.swift
//  icloudauthapp
//
//  Created by shaurya on 1/6/22.
//

import SwiftUI
import Firebase

@main

struct icloudauthappApp: App {
    let persistenceController = PersistenceController.shared
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
  
