//
//  ProfileEditTextView.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 07/10/26.
//

import Foundation
import SwiftUI

struct ProfileEditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocaptalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocaptalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        Mask.mask(mask: mask, value: value, text: &text)
                    }
                }
        }
                
        .padding(.bottom, 10)
    }
}

struct ProfileEditTextView_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                ProfileEditTextView(text: .constant(""), placeholder: "E-mail")
                    .padding()
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
                .previewDevice("iPhone 17")
                .preferredColorScheme($0)
        }
    }
}
