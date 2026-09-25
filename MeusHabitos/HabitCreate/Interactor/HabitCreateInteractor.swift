//
//  HabitCreateInteractor.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 25/09/26.
//

import Foundation
import Combine

class HabitCreateInteractor {
    
    private let remote: HabitCreateRemoteDataSource = .shared
    
}

extension HabitCreateInteractor {
    
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: request)
        
    }
}
