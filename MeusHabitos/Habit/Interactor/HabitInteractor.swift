//
//  HabitInteractor.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 14/07/26.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared
    
}

extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remote.fetchHabits()
        
    }
}
