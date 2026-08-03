//
//  HabitUIState.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 22/06/26.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
