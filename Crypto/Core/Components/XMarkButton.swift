//
//  XMarkButton.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/16.
//

import SwiftUI

struct XMarkButton: View {

    let action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

struct XMarkButton_Previews: PreviewProvider {

    static var previews: some View {
        XMarkButton { }
    }
}
