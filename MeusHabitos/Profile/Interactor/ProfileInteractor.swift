//
//  ProfileInteractor.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 14/08/26.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
}
