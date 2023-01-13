//
//  UIApplication.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/13.
//

import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
