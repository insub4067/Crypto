//
//  CirecleButtonAnimationView.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/11.
//

import SwiftUI

struct CirecleButtonAnimationView: View {

    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none, value: animate)
    }
}

struct CirecleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CirecleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
