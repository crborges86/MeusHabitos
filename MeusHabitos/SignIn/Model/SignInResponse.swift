//
//  SignInResponse.swift
//  MeusHabitos
//
//  Created by Cristiano Ricardo Borges on 11/03/26.
//

import Foundation

struct SignInResponse: Decodable {
    
    let acessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case acessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
