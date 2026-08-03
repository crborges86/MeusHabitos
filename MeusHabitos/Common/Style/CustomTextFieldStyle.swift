//
//  CustomTextFieldStyle.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 10/02/26.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.greenR, lineWidth: 0.8)
            )
    }
}
