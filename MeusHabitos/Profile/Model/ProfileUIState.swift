//
//  ProfileUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 14/08/26.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
