//
//  ContentView.swift
//  UserInterfaceTest
//
//  Created by Vasanth Kumar on 04/08/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    @State private var showLogin = false
    var body: some View {
        VStack {
            Text(!user.isLoggedIn ? "Welcome" : "Welcome \(user.username)")
                .font(.title)
            Spacer().frame(height: 20)
            Button {
                if user.isLoggedIn {
                    user.logout()
                } else {
                    showLogin = true
                }
            } label: {
                Text(user.isLoggedIn ? "Logout" : "Login")
            }
            .accessibilityIdentifier("loginButton")
        }
        .padding()
        .sheet(isPresented: $showLogin) {
                LoginView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
