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
            if user.isLoggedIn {
                    Form {
                        Section {
                            VStack {
                                Text("Color Theme")
                                Picker("", selection: $user.colorTheme) {
                                    Text("Light").tag(0)
                                    Text("Dark").tag(1)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .accessibilityIdentifier("colorTheme")
                            }
                        }
             
                        Section {
                            HStack {
                                Text("Text Size")
                                Slider(value: $user.textSize, in: 1...100)
                                    .accessibilityIdentifier("slider")
                            }
                        }
             
                        Section {
                            VStack {
                                Text("Font")
                                Picker("", selection: $user.font) {
                                    Text("Arial").tag("Arial")
                                    Text("Avenir Next").tag("Avenir Next")
                                    Text("Noteworthy").tag("Noteworthy")
                                    Text("Futura").tag("Futura")
                                }
                                .pickerStyle(WheelPickerStyle())
                                .accessibilityIdentifier("fontPicker")
                            }
                        }
                    }
                }
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
