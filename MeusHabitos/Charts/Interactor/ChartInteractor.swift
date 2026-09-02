//
//  ChartInteractor.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 02/09/26.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let remote: ChartRemoteDataSource = .shared
    
}

extension ChartInteractor {
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remote.fetchHabitValues(habitId: habitId)
    }
    
}
