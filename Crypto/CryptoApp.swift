//
//  CryptoApp.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/11.
//

import SwiftUI

@main
struct CryptoApp: App {

    @StateObject var viewModel = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
