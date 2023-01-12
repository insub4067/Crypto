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
