//
//  HabitDetailUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 20/07/26.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
