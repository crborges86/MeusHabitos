//
//  SignUpUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 28/01/26.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
