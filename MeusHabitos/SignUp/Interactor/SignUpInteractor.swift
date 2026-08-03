//
//  SignUpInteractor.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 30/03/26.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SingUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SignUpInteractor {
    
    func postUser(sigUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remoteSignUp.postUser(request: request)
    }
    
    func login(sigInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.inserUserAuth(userAuth: userAuth)
    }
}
