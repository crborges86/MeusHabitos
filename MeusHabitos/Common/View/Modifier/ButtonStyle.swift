//
//  ButtonStyle.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 25/06/26.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(. title3).bold())
            .background(Color.greenR)
            .foregroundColor(.white)
            .cornerRadius(4.0)
    }
}
