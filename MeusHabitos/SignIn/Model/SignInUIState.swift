//
//  SignInUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 15/01/26.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
