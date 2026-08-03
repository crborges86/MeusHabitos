//
//  SignUpRemotoDataSource.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 30/03/26.
//

import Foundation
import Combine

class SingUpRemoteDataSource {
    
    static var shared: SingUpRemoteDataSource = SingUpRemoteDataSource()
    
    private init() {
        
    }
    
  func postUser(request: SignUpRequest) -> Future<Bool, AppError> {
      return Future{ promise in
          WebService.call(path: .postUser, method: .post, body: request) { result in
            switch result {
              case .failure(let error, let data):
                if let data = data {
                    if error == .badRequest{
                        let decoder = JSONDecoder()
                        let response = try?  decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")
                        ))
                    }
                }
                break
              case .success(_):
                promise(.success(true))
                break
            }
          }
        }
      }
    
    
}
